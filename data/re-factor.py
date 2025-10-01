#!/usr/bin/env python3
"""
Read 2 rows of redcathode/thingiverse-openscad dataset
Extract 'name' column, 'scad' column, and 'fakeprompt' column
Clean up the scad column (containing scad code):
    Extract code inside ''' '''
    Remove lines starting with * (all metadata - unrelated)
    Try rendering this code
    If successful, this is the code we need
Save this new data in a new dataset
    'name' column saved as 'object'
    cleaned 'scad' column saved as 'scad'
    'fakeprompt' column saved as description
For each column, save this procedurely to json file
At the end, upload this json file to HF dataset as ThomasTheMaker/OpenSCAD --repo-type=dataset
"""

import json
import re
import subprocess
import tempfile
import os
import time
from multiprocessing import Pool, Lock, Manager
from datasets import load_dataset
from huggingface_hub import HfApi

# Global lock for file writing
file_lock = None

def extract_code_from_triple_quotes(text):
    """Extract code from within ``` ``` blocks or ''' ''' blocks."""
    # Try ``` first (markdown style)
    pattern = r"```(.*?)```"
    matches = re.findall(pattern, text, re.DOTALL)
    if matches:
        return matches[0]

    # Try ''' (python style)
    pattern = r"'''(.*?)'''"
    matches = re.findall(pattern, text, re.DOTALL)
    if matches:
        return matches[0]

    # If no matches, return as-is
    return text

def remove_metadata_lines(code):
    """Remove lines starting with * (metadata lines)."""
    lines = code.split('\n')
    cleaned_lines = [line for line in lines if not line.strip().startswith('*')]
    return '\n'.join(cleaned_lines)

def clean_scad_code(scad_text):
    """Clean up SCAD code by extracting from quotes and removing metadata."""
    # Extract code from triple quotes
    code = extract_code_from_triple_quotes(scad_text)
    # Remove metadata lines
    code = remove_metadata_lines(code)

    # Remove header comments (emails, copyright, license, etc.)
    lines = code.split('\n')
    cleaned_lines = []
    skip_header = True

    for line in lines:
        stripped = line.strip()
        # Skip comment lines at the beginning until we hit actual code
        if skip_header:
            if stripped.startswith('//') or stripped == '':
                continue
            else:
                skip_header = False
        cleaned_lines.append(line)

    return '\n'.join(cleaned_lines).strip()

def try_render_scad(code):
    """Try to render SCAD code using OpenSCAD. Returns True if successful."""
    try:
        with tempfile.NamedTemporaryFile(mode='w', suffix='.scad', delete=False) as f:
            f.write(code)
            scad_file = f.name

        with tempfile.NamedTemporaryFile(suffix='.stl', delete=False) as f:
            stl_file = f.name

        # Try to render with OpenSCAD
        result = subprocess.run(
            ['openscad', '-o', stl_file, scad_file],
            capture_output=True,
            timeout=30
        )

        # Clean up temp files
        os.unlink(scad_file)
        if os.path.exists(stl_file):
            os.unlink(stl_file)

        return result.returncode == 0
    except Exception:
        return False

def process_row(args):
    """Process a single row - designed for parallel execution."""
    idx, row, output_file = args

    name = row['name']
    scad_raw = row['scad']
    fakeprompt = row['fakeprompt']

    # Clean SCAD code
    cleaned_scad = clean_scad_code(scad_raw)

    # Try rendering
    renders_successfully = try_render_scad(cleaned_scad)

    if renders_successfully:
        result = {
            'object': name,
            'scad': cleaned_scad,
            'description': fakeprompt
        }

        # Save incrementally to file (thread-safe)
        global file_lock
        if file_lock:
            with file_lock:
                try:
                    # Read existing data
                    if os.path.exists(output_file):
                        with open(output_file, 'r', encoding='utf-8') as f:
                            data = json.load(f)
                    else:
                        data = []

                    # Append new result
                    data.append(result)

                    # Write back
                    with open(output_file, 'w', encoding='utf-8') as f:
                        json.dump(data, f, indent=2, ensure_ascii=False)
                except Exception as e:
                    print(f"Error saving {name}: {e}")

        return (idx, name, True)
    else:
        return (idx, name, False)

def init_lock(l):
    """Initialize the global lock for worker processes."""
    global file_lock
    file_lock = l

def main():
    # Load dataset (all rows)
    print("Loading dataset...")
    dataset = load_dataset("redcathode/thingiverse-openscad", split="train")

    output_file = 'openscad_dataset.json'

    # Load already processed names to skip them
    processed_names = set()
    if os.path.exists(output_file):
        print(f"Found existing progress file, loading...")
        with open(output_file, 'r', encoding='utf-8') as f:
            existing_data = json.load(f)
            processed_names = {entry['object'] for entry in existing_data}
        print(f"Skipping {len(processed_names)} already processed entries")

    # Filter out already processed rows
    rows_to_process = [(idx, row, output_file) for idx, row in enumerate(dataset)
                       if row['name'] not in processed_names]

    total_rows = len(rows_to_process)
    print(f"Processing {total_rows} remaining rows with 30 parallel workers...")

    # Create a lock for file writing
    manager = Manager()
    lock = manager.Lock()

    # Process in parallel
    start_time = time.time()
    successful = 0
    failed = 0

    with Pool(processes=30, initializer=init_lock, initargs=(lock,)) as pool:
        for i, result in enumerate(pool.imap_unordered(process_row, rows_to_process)):
            idx, name, success = result

            if success:
                successful += 1
                status = "✓"
            else:
                failed += 1
                status = "✗"

            # Calculate ETA
            elapsed = time.time() - start_time
            processed = i + 1
            if processed > 0:
                avg_time_per_row = elapsed / processed
                remaining_rows = total_rows - processed
                eta_seconds = avg_time_per_row * remaining_rows
                eta_min = int(eta_seconds // 60)
                eta_sec = int(eta_seconds % 60)
                eta_str = f"ETA: {eta_min}m {eta_sec}s"
            else:
                eta_str = "ETA: calculating..."

            print(f"{status} [{processed}/{total_rows}] {name} ({eta_str}) [Success: {successful}, Failed: {failed}]")

    # Final summary
    print(f"\n{'='*80}")
    print(f"Processing complete!")
    print(f"Total processed: {successful + failed}")
    print(f"Successful: {successful}")
    print(f"Failed: {failed}")
    print(f"Saved to {output_file}")

    # Upload to HuggingFace
    print("\nUploading to HuggingFace...")
    api = HfApi()

    # Create repository if it doesn't exist
    repo_id = "ThomasTheMaker/OpenSCAD"
    try:
        api.create_repo(repo_id=repo_id, repo_type="dataset", exist_ok=True)
        print(f"Repository {repo_id} ready")
    except Exception as e:
        print(f"Note: {e}")

    # Upload file
    api.upload_file(
        path_or_fileobj=output_file,
        path_in_repo="data.json",
        repo_id=repo_id,
        repo_type="dataset"
    )

    print("✓ Upload complete!")

if __name__ == "__main__":
    main()
