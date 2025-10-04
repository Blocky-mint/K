#!/usr/bin/env python3
"""
Complete OpenSCAD Dataset Generator

Usage:
  python generate_dataset.py        # Process entire dataset
  python generate_dataset.py test   # Test mode: only first 200 rows

Features:
- Downloads from redcathode/thingiverse-openscad
- Removes ALL comments (// and /* */)
- Removes non-ASCII characters
- Validates by rendering with OpenSCAD
- Parallel processing (30 workers)
- Resume capability
- Auto-uploads to HuggingFace

Output: openscad_dataset.json + uploads to ThomasTheMaker/OpenSCAD
"""

import json
import re
import subprocess
import tempfile
import os
import time
import sys
from multiprocessing import Pool, Manager
from datasets import load_dataset, Dataset

# Configuration
NUM_WORKERS = 30
RENDER_TIMEOUT = 30

# Test mode configuration
TEST_MODE = len(sys.argv) > 1 and sys.argv[1] == 'test'
TEST_LIMIT = 200
OUTPUT_FILE = 'openscad_dataset_test.json' if TEST_MODE else 'openscad_dataset.json'
REPO_ID = "ThomasTheMaker/OpenSCAD-test" if TEST_MODE else "ThomasTheMaker/OpenSCAD"

file_lock = None

def remove_comments(code):
    """Remove all comments from OpenSCAD code."""
    # Remove multi-line comments /* ... */
    code = re.sub(r'/\*.*?\*/', '', code, flags=re.DOTALL)

    # Remove single-line comments //
    lines = code.split('\n')
    cleaned_lines = []

    for line in lines:
        in_string = False
        cleaned_line = []
        i = 0

        while i < len(line):
            char = line[i]

            if char == '"' and (i == 0 or line[i-1] != '\\'):
                in_string = not in_string
                cleaned_line.append(char)
                i += 1
                continue

            if not in_string and i < len(line) - 1:
                if char == '/' and line[i+1] == '/':
                    break

            cleaned_line.append(char)
            i += 1

        line_result = ''.join(cleaned_line).rstrip()
        if line_result:
            cleaned_lines.append(line_result)

    return '\n'.join(cleaned_lines)

def clean_scad_code(scad_text):
    """Clean SCAD code: remove comments, non-ASCII, metadata."""
    # Extract from triple quotes if present
    pattern = r"```(.*?)```"
    matches = re.findall(pattern, scad_text, re.DOTALL)
    if matches:
        code = matches[0]
    else:
        pattern = r"'''(.*?)'''"
        matches = re.findall(pattern, scad_text, re.DOTALL)
        code = matches[0] if matches else scad_text

    # Remove metadata lines (starting with *)
    lines = code.split('\n')
    lines = [line for line in lines if not line.strip().startswith('*')]
    code = '\n'.join(lines)

    # Remove ALL comments
    code = remove_comments(code)

    # Remove non-ASCII characters
    code = code.encode('ascii', 'ignore').decode('ascii')

    # Clean up whitespace
    lines = code.split('\n')
    cleaned_lines = [line.rstrip() for line in lines if line.strip()]

    return '\n'.join(cleaned_lines).strip()

def try_render_scad(code):
    """Validate code by rendering with OpenSCAD."""
    try:
        with tempfile.NamedTemporaryFile(mode='w', suffix='.scad', delete=False) as f:
            f.write(code)
            scad_file = f.name

        with tempfile.NamedTemporaryFile(suffix='.stl', delete=False) as f:
            stl_file = f.name

        result = subprocess.run(
            ['openscad', '-o', stl_file, scad_file],
            capture_output=True,
            timeout=RENDER_TIMEOUT
        )

        os.unlink(scad_file)
        if os.path.exists(stl_file):
            os.unlink(stl_file)

        return result.returncode == 0
    except Exception:
        return False

def process_row(args):
    """Process single row in parallel."""
    idx, row, output_file = args

    name = row['name']
    scad_raw = row['scad']
    fakeprompt = row['fakeprompt']

    cleaned_scad = clean_scad_code(scad_raw)

    if len(cleaned_scad) < 10:
        return (idx, name, False)

    if try_render_scad(cleaned_scad):
        cleaned_description = fakeprompt.encode('ascii', 'ignore').decode('ascii')

        # Format object name with prompt prefix
        formatted_object = f"Hey cadmonkey, make me a {name}"

        result = {
            'object': formatted_object,
            'scad': cleaned_scad,
            'description': cleaned_description
        }

        global file_lock
        if file_lock:
            with file_lock:
                try:
                    if os.path.exists(output_file):
                        with open(output_file, 'r', encoding='utf-8') as f:
                            data = json.load(f)
                    else:
                        data = []

                    data.append(result)

                    with open(output_file, 'w', encoding='utf-8') as f:
                        json.dump(data, f, indent=2, ensure_ascii=False)
                except Exception as e:
                    print(f"Error saving {name}: {e}")

        return (idx, name, True)
    else:
        return (idx, name, False)

def init_lock(l):
    """Initialize lock for worker processes."""
    global file_lock
    file_lock = l

def main():
    print("="*80)
    if TEST_MODE:
        print("OPENSCAD DATASET GENERATOR - TEST MODE")
        print(f"Processing first {TEST_LIMIT} rows only")
    else:
        print("OPENSCAD DATASET GENERATOR - FULL MODE")
    print("="*80)

    # Load source dataset
    print("\nLoading redcathode/thingiverse-openscad...")
    dataset = load_dataset("redcathode/thingiverse-openscad", split="train")
    print(f"✓ Loaded {len(dataset)} entries")

    # Test mode: limit dataset
    if TEST_MODE:
        print(f"✓ Test mode: limiting to first {TEST_LIMIT} entries")
        dataset = dataset.select(range(min(TEST_LIMIT, len(dataset))))

    # Check for existing progress
    processed_names = set()
    if os.path.exists(OUTPUT_FILE):
        print(f"\nFound existing {OUTPUT_FILE}, resuming...")
        with open(OUTPUT_FILE, 'r', encoding='utf-8') as f:
            existing_data = json.load(f)
            processed_names = {entry['object'] for entry in existing_data}
        print(f"✓ Skipping {len(processed_names)} already processed")

    # Filter rows to process
    rows_to_process = [(idx, row, OUTPUT_FILE) for idx, row in enumerate(dataset)
                       if row['name'] not in processed_names]

    total_rows = len(rows_to_process)

    if total_rows == 0:
        print("\n✓ All entries already processed!")
    else:
        print(f"\nProcessing {total_rows} rows with {NUM_WORKERS} workers...")
        print("Removing comments, validating with OpenSCAD...\n")

        manager = Manager()
        lock = manager.Lock()

        start_time = time.time()
        successful = 0
        failed = 0

        with Pool(processes=NUM_WORKERS, initializer=init_lock, initargs=(lock,)) as pool:
            for i, result in enumerate(pool.imap_unordered(process_row, rows_to_process)):
                idx, name, success = result

                if success:
                    successful += 1
                    status = "✓"
                else:
                    failed += 1
                    status = "✗"

                elapsed = time.time() - start_time
                processed = i + 1
                if processed > 0:
                    avg_time = elapsed / processed
                    remaining = total_rows - processed
                    eta_sec = avg_time * remaining
                    eta_str = f"{int(eta_sec//60)}m {int(eta_sec%60)}s"
                else:
                    eta_str = "calculating..."

                print(f"{status} [{processed}/{total_rows}] {name[:50]} (ETA: {eta_str}) [✓{successful} ✗{failed}]")

        print(f"\n{'='*80}")
        print(f"PROCESSING COMPLETE")
        print(f"{'='*80}")
        print(f"Successful: {successful}")
        print(f"Failed: {failed}")
        print(f"Saved to: {OUTPUT_FILE}")

    # Upload to HuggingFace
    print(f"\n{'='*80}")
    print("UPLOADING TO HUGGINGFACE")
    print(f"{'='*80}")

    with open(OUTPUT_FILE, 'r', encoding='utf-8') as f:
        data = json.load(f)

    print(f"Loading {len(data)} entries...")

    hf_dataset = Dataset.from_dict({
        'object': [e['object'] for e in data],
        'scad': [e['scad'] for e in data],
        'description': [e['description'] for e in data]
    })

    hf_token = os.getenv("HF_TOKEN")
    if not hf_token:
        try:
            from huggingface_hub import HfFolder
            hf_token = HfFolder.get_token()
        except Exception:
            hf_token = None

    if not hf_token:
        print("⚠ HF_TOKEN not found. Dataset saved locally only.")
        print("Set HF_TOKEN to enable upload.")
    else:
        print(f"Uploading to {REPO_ID}...")
        try:
            hf_dataset.push_to_hub(
                REPO_ID,
                token=hf_token,
                commit_message="Clean: comment-free, ASCII-only, renderable OpenSCAD"
            )
            print(f"✓ Uploaded to https://huggingface.co/datasets/{REPO_ID}")
        except Exception as e:
            print(f"✗ Upload failed: {e}")

    if TEST_MODE:
        print(f"\n🎉 Test complete! Check {OUTPUT_FILE} to verify results.")
        print("To process full dataset, run: python generate_dataset.py")
    else:
        print("\n🎉 Done! Dataset ready for training.")

if __name__ == "__main__":
    main()
