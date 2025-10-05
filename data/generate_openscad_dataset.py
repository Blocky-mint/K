#!/usr/bin/env python3
"""
Generate OpenSCAD dataset using Ollama gemma3:12b
Validates each generated code by rendering, then saves to HF dataset
"""

import json
import subprocess
import tempfile
import os
from pathlib import Path
from datasets import Dataset, Image
import requests
import time
from datetime import timedelta
from PIL import Image as PILImage

def call_ollama(prompt):
    """Call Ollama API with gemma3:12b model"""
    url = "http://localhost:11434/api/generate"
    payload = {
        "model": "gemma3:12b",
        "prompt": prompt,
        "stream": False
    }

    response = requests.post(url, json=payload)
    if response.status_code == 200:
        return response.json()['response']
    else:
        raise Exception(f"Ollama API error: {response.status_code}")

def validate_and_render_openscad(code, save_image_path=None):
    """Render OpenSCAD code to verify it's valid. Returns (success, error_message, image_path)"""
    with tempfile.TemporaryDirectory() as tmpdir:
        scad_file = Path(tmpdir) / "test.scad"
        output_file = Path(tmpdir) / "output.stl"

        # Write the code to a temporary file
        scad_file.write_text(code)

        # Try to render STL
        try:
            result = subprocess.run(
                ["openscad", "-o", str(output_file), str(scad_file)],
                capture_output=True,
                timeout=30,
                text=True
            )

            # Check if output file was created and has content
            if result.returncode == 0 and output_file.exists() and output_file.stat().st_size > 0:
                # Also render an image if requested
                image_path = None
                if save_image_path:
                    image_path = save_image_path
                    # Use xvfb-run for headless rendering
                    img_result = subprocess.run(
                        ["xvfb-run", "-a", "openscad", "-o", str(image_path), "--autocenter", "--viewall",
                         "--colorscheme", "Tomorrow", "--imgsize=512,512",
                         "--projection=ortho", "--camera=0,0,0,55,0,25,500", str(scad_file)],
                        capture_output=True,
                        timeout=30,
                        text=True
                    )
                    # Check if image was actually created and has content
                    if img_result.returncode != 0 or not Path(image_path).exists() or Path(image_path).stat().st_size == 0:
                        print(f"Image render warning: {img_result.stderr[:100] if img_result.stderr else 'Empty file'}")
                        image_path = None

                return True, None, image_path
            else:
                error_msg = result.stderr if result.stderr else result.stdout
                return False, error_msg, None
        except subprocess.TimeoutExpired:
            return False, "Rendering timed out after 30 seconds", None
        except Exception as e:
            return False, str(e), None

def extract_code(response):
    """Extract OpenSCAD code from model response, removing markdown if present"""
    code = response.strip()
    if "```" in code:
        # Extract code block
        lines = code.split('\n')
        code_lines = []
        in_code = False
        for line in lines:
            if line.strip().startswith("```"):
                in_code = not in_code
                continue
            if in_code:
                code_lines.append(line)
        code = '\n'.join(code_lines)
    return code.strip()

def generate_openscad_entry(object_name, image_dir, index):
    """Generate a single dataset entry for an object with feedback loop"""
    initial_prompt = f"Generate OpenSCAD code to create a {object_name}. Only provide the code, no explanations."

    max_retries = 3
    prompt = initial_prompt
    previous_code = None

    for attempt in range(max_retries):
        try:
            # Get code from Ollama
            response = call_ollama(prompt)
            code = extract_code(response)

            # Validate by rendering STL only (skip image for now)
            success, error_msg, _ = validate_and_render_openscad(code)

            if success:
                # Try to render image - if it fails, we'll use placeholder later
                image_path = image_dir / f"{index:05d}_{object_name}.png"
                try:
                    _, _, _ = validate_and_render_openscad(code, str(image_path))
                except:
                    pass  # Image rendering failed, will use placeholder

                return {
                    "prompt": f"hey cadmoney, create me a {object_name}",
                    "response": code,
                    "image": str(image_path)
                }
            else:
                # Provide feedback to the model about the error
                print(f"Attempt {attempt + 1}/{max_retries} failed for {object_name}")
                print(f"Error: {error_msg[:200] if error_msg else 'Unknown error'}...")

                # Create feedback prompt for next iteration
                prompt = f"""The following OpenSCAD code for a {object_name} failed to render with this error:

{error_msg}

Previous code:
{code}

Please fix the code to resolve this error. Only provide the corrected code, no explanations."""

                previous_code = code

        except Exception as e:
            print(f"Error generating {object_name}: {e}")

    return None

def format_time(seconds):
    """Format seconds into human-readable time"""
    return str(timedelta(seconds=int(seconds)))

def load_progress():
    """Load the most recent checkpoint if it exists"""
    checkpoint_files = list(Path(".").glob("checkpoint_*.json"))

    if checkpoint_files:
        # Sort by numeric index, not alphabetically
        checkpoint_files = sorted(checkpoint_files,
                                  key=lambda x: int(x.stem.split('_')[1]),
                                  reverse=True)
        latest_checkpoint = checkpoint_files[0]
        # Extract the index from filename like "checkpoint_100.json"
        checkpoint_index = int(latest_checkpoint.stem.split('_')[1])

        print(f"Found checkpoint: {latest_checkpoint}")
        print(f"Loading progress from entry {checkpoint_index}...")

        with open(latest_checkpoint, 'r') as f:
            entries = json.load(f)

        # Reconstruct full entries with image paths
        full_entries = []
        for i, entry in enumerate(entries, 1):
            obj_name = entry['prompt'].replace('hey cadmoney, create me a ', '')
            full_entry = {
                "prompt": entry['prompt'],
                "response": entry['response'],
                "image": f"rendered_images/{i:05d}_{obj_name}.png"
            }
            full_entries.append(full_entry)

        return checkpoint_index, full_entries

    return 0, []

def main():
    # Expanded list of objects to generate 7000 rows
    base_objects = [
        "cube", "sphere", "cylinder", "cone", "torus", "pyramid", "prism",
        "box", "ring", "tube", "hexagon", "octagon", "pentagon", "star", "gear",
        "screw", "bolt", "nut", "washer", "spring", "coil", "helix",
        "cup", "mug", "bowl", "plate", "spoon", "fork", "knife",
        "bottle", "jar", "container", "lid", "cap", "stopper", "cork",
        "wheel", "axle", "bearing", "pulley", "lever", "hinge", "joint",
        "bracket", "mount", "stand", "base", "platform", "frame", "support",
        "rod", "shaft", "pin", "peg", "dowel", "stake", "pole",
        "block", "brick", "tile", "panel", "sheet", "slab", "plank",
        "ball", "dome", "hemisphere", "arch", "vault", "pillar", "column",
        "beam", "strut", "brace", "crossbar", "spacer", "shim", "wedge",
        "clip", "clamp", "hook", "latch", "lock", "key", "handle",
        "knob", "button", "switch", "dial", "slider", "toggle", "lever",
        "funnel", "nozzle", "spout", "valve", "pipe", "elbow", "tee",
        "connector", "adapter", "coupler", "fitting", "flange", "gasket",
        "tray", "shelf", "rack", "holder", "organizer", "divider", "separator",
        "ramp", "slope", "step", "stair", "ladder", "rail", "banister",
        "housing", "enclosure", "case", "shell", "cover", "sleeve", "shroud",
        "disk", "plate", "ring", "washer", "spacer", "bushing", "collar"
    ]

    # Generate 10000 entries by cycling through objects
    target_count = 10000
    objects = []
    for i in range(target_count):
        obj = base_objects[i % len(base_objects)]
        objects.append(obj)

    # Create images directory
    image_dir = Path("rendered_images")
    image_dir.mkdir(exist_ok=True)

    # Try to resume from checkpoint
    start_index, dataset_entries = load_progress()
    timings = []

    if start_index > 0:
        print(f"Resuming from entry {start_index + 1}/{len(objects)}")
        print(f"Already completed: {len(dataset_entries)} entries\n")
    else:
        print(f"Starting fresh - generating dataset with {len(objects)} entries...")
        dataset_entries = []

    for i, obj in enumerate(objects, 1):
        # Skip already processed entries
        if i <= start_index:
            continue

        start_time = time.time()

        # Calculate ETA
        if timings:
            avg_time = sum(timings) / len(timings)
            remaining = len(objects) - i + 1
            eta_seconds = avg_time * remaining
            eta_str = format_time(eta_seconds)
            print(f"\n[{i}/{len(objects)}] Generating {obj}... (Avg: {avg_time:.1f}s/obj, ETA: {eta_str})")
        else:
            print(f"\n[{i}/{len(objects)}] Generating {obj}...")

        entry = generate_openscad_entry(obj, image_dir, i)

        elapsed = time.time() - start_time
        timings.append(elapsed)

        if entry:
            dataset_entries.append(entry)
            print(f"✓ Successfully generated and validated {obj} in {elapsed:.1f}s")
        else:
            print(f"✗ Failed to generate valid code for {obj} after {elapsed:.1f}s")

        # Save checkpoint every 100 entries
        if i % 100 == 0 and dataset_entries:
            print(f"\n💾 Checkpoint: Saving {len(dataset_entries)} entries...")
            checkpoint_file = f"checkpoint_{i}.json"
            json_entries = [{k: v for k, v in entry.items() if k != 'image'} for entry in dataset_entries]
            with open(checkpoint_file, "w") as f:
                json.dump(json_entries, f, indent=2)
            print(f"Checkpoint saved to {checkpoint_file}")

    print(f"\n\nSuccessfully generated {len(dataset_entries)} valid entries")

    # Create HuggingFace dataset with Image feature
    if dataset_entries:
        # Load images as PIL Images for proper encoding
        for entry in dataset_entries:
            img_path = Path(entry['image'])
            if img_path.exists() and img_path.stat().st_size > 0:
                try:
                    entry['image'] = PILImage.open(entry['image'])
                except Exception as e:
                    print(f"Warning: Could not load image {entry['image']}: {e}")
                    # Create a blank placeholder image
                    entry['image'] = PILImage.new('RGB', (512, 512), color='gray')
            else:
                print(f"Warning: Image not found or empty at {entry['image']}")
                # Create a blank placeholder image
                entry['image'] = PILImage.new('RGB', (512, 512), color='gray')

        dataset = Dataset.from_list(dataset_entries)

        # Cast the image column to Image type
        dataset = dataset.cast_column("image", Image())

        # Save to disk
        output_dir = "openscad_dataset"
        dataset.save_to_disk(output_dir)
        print(f"\nDataset saved to {output_dir}")

        # Also save as JSON for inspection
        json_entries = [{k: v for k, v in entry.items() if k != 'image'} for entry in dataset_entries]
        with open("openscad_dataset.json", "w") as f:
            json.dump(json_entries, f, indent=2)
        print(f"JSON backup saved to openscad_dataset.json")

        print(f"\nDataset info:")
        print(f"  Total entries: {len(dataset)}")
        print(f"  Columns: {dataset.column_names}")

        # Push to HuggingFace Hub using push_to_hub (handles everything automatically)
        print(f"\nPushing to HuggingFace Hub...")
        try:
            # This will create the repo and upload data in the correct format
            dataset.push_to_hub(
                "ThomasTheMaker/Synthetic-OpenSCAD-16WSL",
                private=False
            )
            print(f"✓ Dataset uploaded to ThomasTheMaker/Synthetic-OpenSCAD-16WSL")
            print(f"  View at: https://huggingface.co/datasets/ThomasTheMaker/Synthetic-OpenSCAD-16WSL")
        except Exception as e:
            print(f"Error uploading to Hub: {e}")
            print("Make sure you're logged in: huggingface-cli login")

            # Fallback: save locally
            parquet_file = "train.parquet"
            dataset.to_parquet(parquet_file)
            print(f"Dataset saved locally as {parquet_file}")
    else:
        print("No valid entries generated")

if __name__ == "__main__":
    main()
