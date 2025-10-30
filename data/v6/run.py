#!/usr/bin/env python3
"""
Script to process the redcathode/thingiverse-openscad dataset:
1. Download images from thumbnail URLs
2. Label images using Ollama llava:7b VLM
3. Clean SCAD code by removing wrapper text
4. Create dataset with 'name', 'image', 'code' columns
"""

import requests
import re
import json
from datasets import load_dataset
from tqdm import tqdm
import ollama
from io import BytesIO
from PIL import Image
import base64


def download_image(url, timeout=10):
    """Download image from URL and return as PIL Image"""
    try:
        response = requests.get(url, timeout=timeout)
        response.raise_for_status()
        return Image.open(BytesIO(response.content))
    except Exception as e:
        print(f"Error downloading {url}: {e}")
        return None


def label_image_with_vlm(image, model="llava:7b"):
    """Send image to Ollama VLM and get label (under 5 words)"""
    try:
        # Convert PIL Image to bytes
        buffered = BytesIO()
        image.save(buffered, format="PNG")
        img_bytes = buffered.getvalue()

        # Encode to base64
        img_base64 = base64.b64encode(img_bytes).decode('utf-8')

        # Call Ollama API
        response = ollama.generate(
            model=model,
            prompt="Describe this object in under 5 words. Be concise and specific.",
            images=[img_base64]
        )

        label = response['response'].strip()

        # Ensure it's under 5 words
        words = label.split()
        if len(words) > 5:
            label = ' '.join(words[:5])

        return label

    except Exception as e:
        print(f"Error labeling image: {e}")
        return None


def clean_scad_code(scad_text):
    """Remove .scad: prefix and ``` wrappers from code"""
    if not scad_text:
        return ""

    # Remove anything like "filename.scad:\n```" at the start
    # Pattern: optional filename, optional .scad, optional colon, optional newlines, optional ```
    cleaned = re.sub(r'^.*?\.scad:\s*```\s*', '', scad_text, flags=re.MULTILINE)

    # Remove trailing ```
    cleaned = re.sub(r'\s*```\s*$', '', cleaned)

    # Also handle cases where there's just ``` without .scad:
    cleaned = re.sub(r'^```\s*', '', cleaned)
    cleaned = re.sub(r'\s*```\s*$', '', cleaned)

    return cleaned.strip()


def process_dataset(dataset_name="redcathode/thingiverse-openscad", split="train", max_samples=None):
    """
    Process the dataset:
    - Download images
    - Label with VLM
    - Clean SCAD code
    - Create new dataset
    """
    print(f"Loading dataset {dataset_name}...")
    dataset = load_dataset(dataset_name, split=split)

    if max_samples:
        dataset = dataset.select(range(min(max_samples, len(dataset))))

    print(f"Processing {len(dataset)} samples...")

    processed_data = []

    for idx, item in enumerate(tqdm(dataset, desc="Processing samples")):
        thumbnail_url = item.get('thumbnail', '')
        scad_code = item.get('scad', '')

        # Download image
        image = download_image(thumbnail_url)
        if image is None:
            print(f"Skipping sample {idx}: Failed to download image")
            continue

        # Label image with VLM
        label = label_image_with_vlm(image)
        if label is None:
            print(f"Skipping sample {idx}: Failed to label image")
            continue

        # Clean SCAD code
        cleaned_code = clean_scad_code(scad_code)

        # Add to processed data
        processed_data.append({
            'name': label,
            'image': thumbnail_url,
            'code': cleaned_code
        })

        # Optional: print progress
        if (idx + 1) % 10 == 0:
            print(f"\nProcessed {idx + 1}/{len(dataset)} samples")
            print(f"Latest label: {label}")

    return processed_data


def save_dataset(data, output_file="labeled_openscad_dataset.json"):
    """Save processed dataset to JSON file"""
    print(f"\nSaving {len(data)} samples to {output_file}...")
    with open(output_file, 'w') as f:
        json.dump(data, f, indent=2)
    print(f"Dataset saved successfully!")


def main():
    """Main function"""
    print("Starting dataset processing...")

    # Optional: set max_samples for testing (None for all)
    max_samples = None  # Set to a small number like 10 for testing

    # Process the dataset
    processed_data = process_dataset(
        dataset_name="redcathode/thingiverse-openscad",
        split="train",
        max_samples=max_samples
    )

    # Save to file
    save_dataset(processed_data, "labeled_openscad_dataset.json")

    print(f"\nComplete! Processed {len(processed_data)} samples.")


if __name__ == "__main__":
    main()
