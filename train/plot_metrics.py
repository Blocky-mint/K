#!/usr/bin/env python3
"""Generate training metrics plot from CSV file"""

import pandas as pd
import matplotlib.pyplot as plt
import sys
import os

# Get CSV file path from command line or use default
csv_file = sys.argv[1] if len(sys.argv) > 1 else "ThomasTheMaker/k-270m/training_metrics.csv"
output_file = csv_file.replace('.csv', '.png')

if not os.path.exists(csv_file):
    print(f"Error: CSV file not found: {csv_file}")
    sys.exit(1)

print(f"Reading metrics from: {csv_file}")
df = pd.read_csv(csv_file)

fig, axes = plt.subplots(2, 2, figsize=(14, 10))
fig.suptitle('Training Metrics', fontsize=16, fontweight='bold')

# Plot 1: Loss over steps
if 'loss' in df.columns and df['loss'].notna().any():
    axes[0, 0].plot(df['step'], df['loss'], linewidth=2, color='#e74c3c')
    axes[0, 0].set_xlabel('Step', fontweight='bold')
    axes[0, 0].set_ylabel('Loss', fontweight='bold')
    axes[0, 0].set_title('Training Loss')
    axes[0, 0].grid(True, alpha=0.3)

# Plot 2: Learning rate over steps
if 'learning_rate' in df.columns and df['learning_rate'].notna().any():
    axes[0, 1].plot(df['step'], df['learning_rate'], linewidth=2, color='#3498db')
    axes[0, 1].set_xlabel('Step', fontweight='bold')
    axes[0, 1].set_ylabel('Learning Rate', fontweight='bold')
    axes[0, 1].set_title('Learning Rate Schedule')
    axes[0, 1].grid(True, alpha=0.3)
    axes[0, 1].ticklabel_format(style='scientific', axis='y', scilimits=(0,0))

# Plot 3: Gradient norm over steps
if 'grad_norm' in df.columns and df['grad_norm'].notna().any():
    axes[1, 0].plot(df['step'], df['grad_norm'], linewidth=2, color='#2ecc71')
    axes[1, 0].set_xlabel('Step', fontweight='bold')
    axes[1, 0].set_ylabel('Gradient Norm', fontweight='bold')
    axes[1, 0].set_title('Gradient Norm')
    axes[1, 0].grid(True, alpha=0.3)

# Plot 4: Loss over epochs
if 'epoch' in df.columns and 'loss' in df.columns and df['loss'].notna().any():
    axes[1, 1].plot(df['epoch'], df['loss'], linewidth=2, color='#9b59b6')
    axes[1, 1].set_xlabel('Epoch', fontweight='bold')
    axes[1, 1].set_ylabel('Loss', fontweight='bold')
    axes[1, 1].set_title('Loss over Epochs')
    axes[1, 1].grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig(output_file, dpi=300, bbox_inches='tight')
print(f"✓ Plot saved to: {output_file}")
plt.close()

# Print summary stats
print("\n" + "="*50)
print("TRAINING METRICS SUMMARY")
print("="*50)
print(f"Total steps: {len(df)}")
if 'loss' in df.columns:
    losses = df['loss'].dropna()
    if len(losses) > 0:
        print(f"Final Loss: {losses.iloc[-1]:.4f}")
        print(f"Initial Loss: {losses.iloc[0]:.4f}")
        print(f"Min Loss: {losses.min():.4f}")
        print(f"Max Loss: {losses.max():.4f}")
print("="*50)
