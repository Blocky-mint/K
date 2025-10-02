#!/usr/bin/env python3
"""
Script to merge LoRA adapters with base model and upload to HuggingFace
This loads the model in 16-bit to avoid quantization issues during merging
"""

import os
import json
from unsloth import FastLanguageModel

# Load configuration
with open('config.json', 'r') as f:
    config = json.load(f)

model_config = config['model_config']
saving_config = config['saving_config']

HUB_MODEL_NAME = model_config['hub_model_name']
BASE_MODEL_NAME = model_config['base_model_name']
MAX_SEQ_LENGTH = model_config['max_seq_length']

# Get HF token
hf_token = os.getenv("HF_TOKEN")
if not hf_token:
    try:
        from huggingface_hub import HfFolder
        hf_token = HfFolder.get_token()
    except Exception:
        hf_token = None

print("="*50)
print("LOADING MODEL WITH LORA ADAPTERS")
print("="*50)

# Load the model in 16-bit (no quantization) with LoRA adapters
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name=HUB_MODEL_NAME,  # Your saved LoRA adapter path
    max_seq_length=MAX_SEQ_LENGTH,
    load_in_4bit=False,
    load_in_8bit=False,  # Load in 16-bit to enable proper merging
    dtype=None,  # Auto-detect
)

print("\n" + "="*50)
print("SAVING 16-BIT MERGED MODEL")
print("="*50)

# Save locally first
local_16bit_path = f"{HUB_MODEL_NAME}_16bit"
model.save_pretrained_merged(local_16bit_path, tokenizer, save_method="merged_16bit")
print(f"✓ 16-bit model saved locally to: {local_16bit_path}")

# Upload to HF Hub
if saving_config['push_to_hub'] and hf_token:
    print(f"\nUploading 16-bit merged model to: {HUB_MODEL_NAME}")
    model.push_to_hub_merged(HUB_MODEL_NAME, tokenizer, save_method="merged_16bit", token=hf_token)
    print(f"✓ 16-bit merged model uploaded to: https://huggingface.co/{HUB_MODEL_NAME}")
    print(f"\n🎉 Model available at: https://huggingface.co/{HUB_MODEL_NAME}")
elif not hf_token:
    print("Warning: HF_TOKEN not found. Skipping upload.")
else:
    print("Push to hub disabled in config")

print("\n" + "="*50)
print("MERGE COMPLETE!")
print("="*50)
