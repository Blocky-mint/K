#!/usr/bin/env python3
"""
OpenSCAD Dataset Labeler

Downloads ThomasTheMaker/Synthetic-Object-v0 dataset, renders OpenSCAD code,
and uses a VLM (via Ollama) to generate new labels for the objects.

Output: JSON dataset with transformed structure:
- code: original OpenSCAD code
- previous_name: original name from dataset
- name: new VLM-generated label (under 5 words)
"""

import json
import subprocess
import tempfile
import os
import time
import requests
from pathlib import Path
from datasets import load_dataset
from PIL import Image
import base64
from io import BytesIO
from concurrent.futures import ProcessPoolExecutor, as_completed
import multiprocessing

# Configuration
OLLAMA_URL = "http://localhost:11434/api/generate"
VISION_MODEL = "llava:7b"  # Vision-capable model for image analysis
TEXT_MODEL = "gemma3:12b"  # Text-only model for fallback reasoning
RENDER_TIMEOUT = 30
MAX_SAMPLES = None  # Process entire dataset (26,480 entries)
MAX_WORKERS = min(8, multiprocessing.cpu_count())  # Parallel workers
SAVE_BATCH_SIZE = 50  # Save results in batches to reduce file I/O contention

def estimate_token_count(text):
    """Estimate token count for a string.

    Tries to use tiktoken if available; otherwise falls back to a simple
    heuristic that assumes ~4 characters per token, which is a common
    approximation for English/code text.
    """
    try:
        import tiktoken  # type: ignore
        encoding = tiktoken.get_encoding("cl100k_base")
        return len(encoding.encode(text))
    except Exception:
        # Fallback: rough heuristic
        return max(1, int(len(text) / 4))

def call_ollama(prompt, model=TEXT_MODEL):
    """Call Ollama API to generate object labels"""
    payload = {
        "model": model,
        "prompt": prompt,
        "stream": False
    }
    
    try:
        response = requests.post(OLLAMA_URL, json=payload, timeout=60)
        if response.status_code == 200:
            return response.json()['response'].strip()
        else:
            print(f"Ollama API error: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error calling Ollama: {e}")
        return None

def render_openscad_to_image(code, index=None):
    """Render OpenSCAD code to an image using Blender"""
    with tempfile.TemporaryDirectory() as tmpdir:
        scad_file = Path(tmpdir) / "render.scad"
        stl_file = Path(tmpdir) / "output.stl"
        image_file = Path(tmpdir) / "output.png"
        
        # Clean the code: convert \n escape sequences to actual newlines
        cleaned_code = code.replace('\\n', '\n')
        
        # Debug: show first 100 chars of cleaned code
        print(f"  📝 Code preview: {cleaned_code[:100]}...")
        
        # Write OpenSCAD code to file
        scad_file.write_text(cleaned_code)
        
        try:
            # First create STL file with OpenSCAD
            stl_result = subprocess.run([
                "openscad", "-o", str(stl_file), str(scad_file)
            ], capture_output=True, timeout=10, text=True)
            
            if stl_result.returncode != 0:
                print(f"OpenSCAD STL creation failed: {stl_result.stderr[:100]}")
                return None
            
            if not stl_file.exists() or stl_file.stat().st_size == 0:
                print("STL file not created or empty")
                return None
            
            # Now render with Blender
            blender_script = f'''
import bpy
import sys
import mathutils

# Clear existing mesh
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)

# Import STL
bpy.ops.wm.stl_import(filepath='{stl_file}')

# Get the imported object and calculate its bounds
imported_obj = None
for obj in bpy.context.scene.objects:
    if obj.type == 'MESH' and obj.name != 'Cube':  # Skip default cube
        imported_obj = obj
        break

if imported_obj:
    # Calculate object bounds
    bbox_corners = [imported_obj.matrix_world @ mathutils.Vector(corner) for corner in imported_obj.bound_box]
    min_coords = mathutils.Vector((min(corner.x for corner in bbox_corners),
                                  min(corner.y for corner in bbox_corners),
                                  min(corner.z for corner in bbox_corners)))
    max_coords = mathutils.Vector((max(corner.x for corner in bbox_corners),
                                  max(corner.y for corner in bbox_corners),
                                  max(corner.z for corner in bbox_corners)))
    
    # Calculate center and size
    center = (min_coords + max_coords) / 2
    size = max_coords - min_coords
    max_size = max(size.x, size.y, size.z)
    
    # Position camera at appropriate distance
    distance = max_size * 3  # 3x the object size
    camera_location = center + mathutils.Vector((distance, -distance, distance))
else:
    # Fallback if no object found
    center = mathutils.Vector((0, 0, 0))
    camera_location = mathutils.Vector((10, -10, 10))

# Set up camera and lighting
bpy.ops.object.camera_add(location=camera_location)
camera = bpy.context.object
camera.rotation_euler = (1.1, 0, 0.785)

# Set camera as active
bpy.context.scene.camera = camera

# Add lighting
bpy.ops.object.light_add(type='SUN', location=(5, 5, 10))

# Set render settings
bpy.context.scene.render.resolution_x = 512
bpy.context.scene.render.resolution_y = 512
bpy.context.scene.render.filepath = '{image_file}'

# Render
bpy.ops.render.render(write_still=True)
'''
            
            script_file = Path(tmpdir) / "render_script.py"
            script_file.write_text(blender_script)
            
            # Run Blender headless
            blender_result = subprocess.run([
                "blender", "--background", "--python", str(script_file)
            ], capture_output=True, timeout=30, text=True)
            
            if blender_result.returncode != 0:
                print(f"Blender rendering failed: {blender_result.stderr[:100]}")
                return None
            
            if image_file.exists() and image_file.stat().st_size > 0:
                print(f"  ✅ Successfully rendered with Blender")
                # Create images directory if it doesn't exist
                images_dir = Path("images")
                images_dir.mkdir(exist_ok=True)
                
                # Copy to images folder with descriptive name
                if index is not None:
                    persistent_image = images_dir / f"render_{index:05d}.png"
                else:
                    persistent_image = images_dir / f"render_{hash(code) % 100000}.png"
                persistent_image.write_bytes(image_file.read_bytes())
                return persistent_image
            else:
                print("Blender did not create image file")
                return None
            
        except subprocess.TimeoutExpired:
            print("Rendering timed out")
            return None
        except Exception as e:
            print(f"Error rendering: {e}")
            return None

def image_to_base64(image_path):
    """Convert image to base64 string for VLM"""
    try:
        with open(image_path, 'rb') as f:
            image_data = f.read()
        return base64.b64encode(image_data).decode('utf-8')
    except Exception as e:
        print(f"Error converting image to base64: {e}")
        return None

def check_object_resemblance(image_path, object_name):
    """Check if the rendered image resembles the original object name"""
    if not os.path.exists(image_path):
        return False, "Image file not found"
    
    # Convert image to base64
    image_b64 = image_to_base64(image_path)
    if not image_b64:
        return False, "Failed to convert image to base64"
    
    # Create prompt for resemblance check - ask for description first
    prompt = f"Look at this 3D rendered object carefully. Describe what shape you see in one word (cube, sphere, cylinder, etc.). Just respond with the shape name."
    
    # Prepare payload for vision model
    payload = {
        "model": VISION_MODEL,
        "prompt": prompt,
        "images": [image_b64],
        "stream": False
    }
    
    try:
        response = requests.post(OLLAMA_URL, json=payload, timeout=30)
        if response.status_code == 200:
            answer = response.json()['response'].strip().lower()
            # Check if the described shape matches the expected object
            described_shape = answer.split()[0] if answer.split() else ""
            expected_shape = object_name.lower()
            
            # Check for similarity (allowing for some variation)
            if expected_shape in described_shape or described_shape in expected_shape:
                return True, f"Described as: {answer}"
            else:
                return False, f"Described as: {answer}"
        else:
            return False, f"VLM API error: {response.status_code}"
    except Exception as e:
        return False, f"VLM API error: {str(e)}"

def generate_label_with_vlm(code, previous_name, image_path):
    """Use VLM to generate a new label for the rendered object"""
    
    # Convert image to base64
    image_b64 = image_to_base64(image_path)
    if not image_b64:
        print(f"  ⚠ No image available, using text-only fallback")
        # Fallback to text-only approach
        prompt = f"""Based on this OpenSCAD code, what object does it create? 
Code: {code}
Original name: {previous_name}

Give me a better, more descriptive name (under 5 words). Just respond with the name, no explanations:"""
        
        label = call_ollama(prompt, TEXT_MODEL)
    else:
        # First check if the image resembles the original object name
        print(f"  🔍 Checking if image resembles '{previous_name}'...")
        resembles, resemblance_response = check_object_resemblance(image_path, previous_name)
        
        if resembles:
            print(f"  ✓ VLM confirms: Image resembles '{previous_name}' - using original name")
            # Use the original name as the label
            label = previous_name
        else:
            print(f"  ✗ VLM says: Image does NOT resemble '{previous_name}' - generating new label")
            # Generate a new label using vision-capable model
            prompt = f"""Look at this 3D rendered object and tell me what it looks like most closely. 
The original name was "{previous_name}" but this image doesn't match that description.
Give me a better, more descriptive name for what you actually see (under 5 words). 
Respond with only the name, no explanations."""
            
            # For vision models, we need to send the image data
            payload = {
                "model": VISION_MODEL,
                "prompt": prompt,
                "images": [image_b64],
                "stream": False
            }
            
            try:
                response = requests.post(OLLAMA_URL, json=payload, timeout=60)
                if response.status_code == 200:
                    label = response.json()['response'].strip()
                else:
                    print(f"  ⚠ Vision API error: {response.status_code}, falling back to text")
                    return None
            except Exception as e:
                print(f"  ⚠ Vision API error: {e}, falling back to text")
                return None
    
    if label:
        # Clean up the response - remove quotes, extra text
        label = label.strip().strip('"').strip("'")
        # Take only first 5 words and convert to lowercase
        words = label.split()[:5]
        return ' '.join(words).lower()
    
    return None

def load_existing_entries(output_file):
    """Load existing entries from JSON file"""
    if os.path.exists(output_file):
        try:
            with open(output_file, 'r') as f:
                return json.load(f)
        except (json.JSONDecodeError, FileNotFoundError):
            return []
    return []

def save_entry_progressively(entry, output_file):
    """Save a single entry to the JSON file"""
    existing_entries = load_existing_entries(output_file)
    existing_entries.append(entry)

    with open(output_file, 'w') as f:
        json.dump(existing_entries, f, indent=2)

def save_batch_entries(entries, output_file):
    """Save multiple entries to the JSON file at once"""
    existing_entries = load_existing_entries(output_file)
    existing_entries.extend(entries)

    with open(output_file, 'w') as f:
        json.dump(existing_entries, f, indent=2)

def process_dataset_entry(entry, index):
    """Process a single dataset entry and return the result"""
    code = entry['code']
    previous_name = entry['name']

    print(f"[{index}] Processing: {previous_name}")

    # Render OpenSCAD code to image
    image_path = render_openscad_to_image(code, index)
    if not image_path:
        print(f"  ✗ Failed to render {previous_name}")
        return None

    # Generate new label using VLM
    new_label = generate_label_with_vlm(code, previous_name, image_path)
    if not new_label:
        print(f"  ✗ Failed to generate label for {previous_name}")
        return None

    # Determine if the label was kept or changed
    label_changed = new_label.lower() != previous_name.lower()
    if label_changed:
        print(f"  ✓ {previous_name} -> {new_label}")
    else:
        print(f"  ✓ {previous_name} (kept original name)")

    # Create and return entry (don't save here - batched in main)
    labeled_entry = {
        "code": code,
        "previous_name": previous_name,
        "name": new_label,
        "label_changed": label_changed
    }

    return labeled_entry

def cleanup_images():
    """Clean up old rendered images"""
    images_dir = Path("images")
    if images_dir.exists():
        for img_file in images_dir.glob("*.png"):
            img_file.unlink()
        print("✓ Cleaned up old images")

def main():
    print("="*80)
    print("OpenSCAD Dataset Labeler")
    print("="*80)
    
    # Clean up old images
    cleanup_images()
    
    # Load the dataset
    print("\nLoading ThomasTheMaker/Synthetic-Object dataset...")
    dataset = load_dataset("ThomasTheMaker/Synthetic-Object-v3", split="train")
    print(f"✓ Loaded {len(dataset)} entries")

    # Filter entries where the OpenSCAD 'code' is under 1024 tokens
    print("Filtering entries with 'code' < 1024 tokens...")
    original_len = len(dataset)
    dataset = dataset.filter(lambda ex: estimate_token_count(ex['code']) < 1024)
    print(f"✓ Filtered: kept {len(dataset)}/{original_len} entries (<1024 tokens)")
    
    # Limit samples for testing (if specified)
    if MAX_SAMPLES:
        dataset = dataset.select(range(min(MAX_SAMPLES, len(dataset))))
        print(f"✓ Limited to {len(dataset)} samples for testing")
    else:
        print(f"✓ Processing entire dataset: {len(dataset)} entries")
    
    # Setup output file
    output_file = "labeled_openscad_dataset.json"
    
    # Check for existing progress
    existing_entries = load_existing_entries(output_file)
    start_index = len(existing_entries)
    
    if start_index > 0:
        print(f"✓ Found existing progress: {start_index} entries already processed")
        print(f"✓ Resuming from entry {start_index + 1}")
    else:
        print(f"✓ Starting fresh")
    
    # Process entries in parallel
    successful_count = start_index
    failed_count = 0
    start_time = time.time()

    print(f"\nProcessing {len(dataset)} entries with {MAX_WORKERS} parallel workers...")
    print("-" * 80)

    # Collect entries to process (skip already processed)
    entries_to_process = [(entry, i + 1) for i, entry in enumerate(dataset) if i >= start_index]

    # Batch results before saving
    result_batch = []
    processed_count = 0

    # Use ProcessPoolExecutor for parallel processing
    with ProcessPoolExecutor(max_workers=MAX_WORKERS) as executor:
        # Submit all tasks
        future_to_index = {
            executor.submit(process_dataset_entry, entry, idx): (entry, idx)
            for entry, idx in entries_to_process
        }

        # Process results as they complete
        for future in as_completed(future_to_index):
            entry, idx = future_to_index[future]
            processed_count += 1

            try:
                result = future.result()
                if result:
                    result_batch.append(result)
                    successful_count += 1
                else:
                    failed_count += 1
            except Exception as e:
                print(f"  ✗ Error processing entry {idx}: {e}")
                failed_count += 1

            # Save batch when it reaches threshold
            if len(result_batch) >= SAVE_BATCH_SIZE:
                save_batch_entries(result_batch, output_file)
                print(f"\n💾 Saved batch of {len(result_batch)} entries")
                result_batch = []

            # Live progress update (overwrites same line)
            elapsed_time = time.time() - start_time
            avg_time_per_entry = elapsed_time / processed_count if processed_count > 0 else 0
            remaining_entries = len(entries_to_process) - processed_count
            estimated_remaining_time = remaining_entries * avg_time_per_entry if avg_time_per_entry > 0 else 0

            current_total = start_index + processed_count
            progress_pct = (current_total/len(dataset))*100

            # Use \r to overwrite the same line
            status = f"\r📊 Progress: {current_total}/{len(dataset)} ({progress_pct:.1f}%) | "
            status += f"✓ {successful_count} ✗ {failed_count} | "
            status += f"Elapsed: {elapsed_time/60:.1f}m | ETA: {estimated_remaining_time/60:.1f}m | "
            status += f"Rate: {60/avg_time_per_entry:.1f}/min" if avg_time_per_entry > 0 else "Rate: calculating..."
            print(status, end='', flush=True)

    # Clear the progress line and save any remaining results
    print()  # Move to new line after progress updates

    if result_batch:
        save_batch_entries(result_batch, output_file)
        print(f"💾 Saved final batch of {len(result_batch)} entries")

    # Final summary
    total_time = time.time() - start_time
    print(f"\n{'='*80}")
    print("PROCESSING COMPLETE")
    print(f"{'='*80}")
    
    final_entries = load_existing_entries(output_file)
    print(f"✓ Total entries in {output_file}: {len(final_entries)}")
    print(f"✓ Success rate: {successful_count}/{len(dataset)} ({successful_count/len(dataset)*100:.1f}%)")
    print(f"✓ Total time: {total_time/60:.1f} minutes")
    print(f"✓ Average time per entry: {total_time/len(dataset):.2f} seconds")
    
    # Show label change statistics
    if final_entries:
        labels_kept = sum(1 for entry in final_entries if not entry.get('label_changed', True))
        labels_changed = sum(1 for entry in final_entries if entry.get('label_changed', False))
        print(f"✓ Labels kept: {labels_kept} ({labels_kept/len(final_entries)*100:.1f}%)")
        print(f"✓ Labels changed: {labels_changed} ({labels_changed/len(final_entries)*100:.1f}%)")
        
        print(f"\nSample results:")
        for i, entry in enumerate(final_entries[-5:]):  # Show last 5 entries
            status = "CHANGED" if entry.get('label_changed', False) else "KEPT"
            print(f"  {i+1}. {entry['previous_name']} -> {entry['name']} [{status}]")
            print(f"     Code: {entry['code'][:50]}...")
    
    print(f"\n🎉 Dataset labeling complete!")
    print(f"Output file: {output_file}")

if __name__ == "__main__":
    main()
