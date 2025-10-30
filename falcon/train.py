from unsloth import FastLanguageModel
import torch
import json
from pathlib import Path

# Load configuration
config_path = Path(__file__).parent / "config.json"
with open(config_path, "r") as f:
    config = json.load(f)

# Model configuration
max_seq_length = config["model"]["max_seq_length"]
dtype = config["model"]["dtype"]
load_in_4bit = config["model"]["load_in_4bit"]

model, tokenizer = FastLanguageModel.from_pretrained(
    model_name=config["model"]["name"],
    max_seq_length=max_seq_length,
    dtype=dtype,
    load_in_4bit=load_in_4bit
)


model = FastLanguageModel.get_peft_model(
    model,
    r=config["lora"]["r"],
    target_modules=config["lora"]["target_modules"],
    lora_alpha=config["lora"]["lora_alpha"],
    lora_dropout=config["lora"]["lora_dropout"],
    use_gradient_checkpointing=config["lora"]["use_gradient_checkpointing"],
    random_state=config["lora"]["random_state"],
)


alpaca_prompt = """Below is an instruction that describes a task, paired with an input that provides further context. Write a response that appropriately completes the request.

### Instruction:
{}

### Input:
{}

### Response:
{}"""

EOS_TOKEN = tokenizer.eos_token

def formatting_prompts_func(examples):
    instructions = [""] * len(examples["name"])
    inputs = [config["dataset"]["prompt_prefix"] + name for name in examples["name"]]
    outputs = examples["code"]
    texts = []
    for instruction, input, output in zip(instructions, inputs, outputs):
        text = alpaca_prompt.format(instruction, input, output) + EOS_TOKEN
        texts.append(text)
    return {"text": texts}

from datasets import load_dataset
dataset = load_dataset(config["dataset"]["name"], split=config["dataset"]["split"])
dataset = dataset.map(formatting_prompts_func, batched=True)


from trl import SFTConfig, SFTTrainer
trainer = SFTTrainer(
    model=model,
    tokenizer=tokenizer,
    train_dataset=dataset,
    dataset_text_field="text",
    max_seq_length=max_seq_length,
    dataset_num_proc=config["training"]["dataset_num_proc"],
    packing=config["training"]["packing"],
    args=SFTConfig(
        per_device_train_batch_size=config["training"]["per_device_train_batch_size"],
        gradient_accumulation_steps=config["training"]["gradient_accumulation_steps"],
        warmup_steps=config["training"]["warmup_steps"],
        max_steps=config["training"]["max_steps"],
        learning_rate=config["training"]["learning_rate"],
        logging_steps=config["training"]["logging_steps"],
        optim=config["training"]["optim"],
        weight_decay=config["training"]["weight_decay"],
        lr_scheduler_type=config["training"]["lr_scheduler_type"],
        seed=config["training"]["seed"],
        output_dir=config["training"]["output_dir"],
        report_to=config["training"]["report_to"],
    ),
)


# @title Show current memory stats
gpu_stats = torch.cuda.get_device_properties(0)
start_gpu_memory = round(torch.cuda.max_memory_reserved() / 1024 / 1024 / 1024, 3)
max_memory = round(gpu_stats.total_memory / 1024 / 1024 / 1024, 3)
print(f"GPU = {gpu_stats.name}. Max memory = {max_memory} GB.")
print(f"{start_gpu_memory} GB of memory reserved.")


trainer_stats = trainer.train()


#@title Show final memory and time stats
used_memory = round(torch.cuda.max_memory_reserved() / 1024 / 1024 / 1024, 3)
used_memory_for_lora = round(used_memory - start_gpu_memory, 3)
used_percentage = round(used_memory         /max_memory*100, 3)
lora_percentage = round(used_memory_for_lora/max_memory*100, 3)
print(f"{trainer_stats.metrics['train_runtime']} seconds used for training.")
print(f"{round(trainer_stats.metrics['train_runtime']/60, 2)} minutes used for training.")
print(f"Peak reserved memory = {used_memory} GB.")
print(f"Peak reserved memory for training = {used_memory_for_lora} GB.")
print(f"Peak reserved memory % of max memory = {used_percentage} %.")
print(f"Peak reserved memory for training % of max memory = {lora_percentage} %.")


# Test inference with streaming
FastLanguageModel.for_inference(model)
inputs = tokenizer(
[
    alpaca_prompt.format(
        "Continue the fibonnaci sequence.", # instruction
        "1, 1, 2, 3, 5, 8", # input
        "", # output - leave this blank for generation!
    )
], return_tensors = "pt").to("cuda")

from transformers import TextStreamer
text_streamer = TextStreamer(tokenizer)
_ = model.generate(**inputs, streamer = text_streamer, max_new_tokens = 128)



# Save merged model (16bit)
print("\n" + "="*50)
print(f"Saving merged 16-bit model: {config['output']['model_name']}")
print("="*50)
model.save_pretrained_merged(
    config["output"]["merged_model_dir"],
    tokenizer,
    save_method="merged_16bit"
)
print(f"✓ Merged model saved locally to: {config['output']['merged_model_dir']}")

# Push to HF Hub if enabled (uses huggingface-cli login credentials)
if config["output"]["push_to_hub"]:
    print(f"Uploading merged model to: {config['output']['model_name']}")
    model.push_to_hub_merged(
        config["output"]["model_name"],
        tokenizer,
        save_method="merged_16bit"
    )
    print(f"✓ Merged model uploaded to: https://huggingface.co/{config['output']['model_name']}")

# Export to GGUF formats
print("\n" + "="*50)
print("Exporting to GGUF formats...")
print("="*50)
model.save_pretrained_gguf(
    config["output"]["gguf_model_name"],
    tokenizer,
    quantization_method=config["output"]["gguf_quantizations"]
)
print(f"✓ GGUF models saved: {', '.join(config['output']['gguf_quantizations'])}")
print(f"✓ Location: {config['output']['gguf_model_name']}")

print("\n" + "="*50)
print("🎉 TRAINING & EXPORT COMPLETE!")
print("="*50)
print(f"Model name: {config['output']['model_name']}")
print(f"Merged model: {config['output']['merged_model_dir']}/")
print(f"GGUF models: {config['output']['gguf_model_name']}/")
if config["output"]["push_to_hub"]:
    print(f"Hub URL: https://huggingface.co/{config['output']['model_name']}")
print("="*50)
