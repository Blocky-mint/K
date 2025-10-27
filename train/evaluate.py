#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Model Evaluation Script
Evaluates the finetuned model by generating OpenSCAD code and checking render success
"""

import os
import json
import subprocess
import re
import tempfile
from pathlib import Path
from huggingface_hub import hf_hub_download
from datetime import datetime

# =============================================================================
# CONFIGURATION
# =============================================================================

def load_config():
    """Load configuration from config.json"""
    with open('config.json', 'r') as f:
        return json.load(f)

# Test objects to evaluate - comprehensive list of 200+ objects
TEST_OBJECTS = [
    # Basic shapes
    "cube", "sphere", "cylinder", "cone", "pyramid", "torus", "tetrahedron", "octahedron",
    # Polygonal shapes
    "pentagon", "hexagon", "heptagon", "octagon", "nonagon", "decagon", "dodecagon",
    # Prisms
    "triangular prism", "square prism", "pentagonal prism", "hexagonal prism", "rectangular prism",
    # Boxes and variations
    "box", "tall box", "wide box", "thin box", "box with rounded corners", "hollow box", "box with holes",
    # Cylinders and variations
    "tall cylinder", "short cylinder", "thick cylinder", "thin cylinder", "cone", "frustum",
    # Stars and polygons
    "star", "6-pointed star", "8-pointed star", "five-pointed star", "crescent", "donut",
    # Complex geometric shapes
    "cube with hole", "sphere with hole", "cube with spheres", "interlocking cubes", "sierpinski pyramid",
    # Decorative shapes
    "flower", "flower with petals", "gear", "spiral", "helix", "wave", "ripple",
    # Functional shapes
    "bracket", "clamp", "hinge", "hook", "ring", "washer", "bushing", "spacer",
    # Letters and text
    "letter A", "letter B", "letter O", "letter S", "letter T", "number 0", "number 1", "number 8",
    # Animals (simplified)
    "cube with eyes", "pyramid with face", "sphere head", "cylinder body", "bird shape", "fish",
    # Architecture
    "arch", "dome", "cube tower", "pyramid tower", "wall block", "brick", "corner piece",
    # Organic shapes
    "blob", "random shape", "organic form", "bumpy sphere", "wrinkled cube", "twisted cylinder",
    # Mechanical parts
    "bolt", "screw", "nut", "spring", "pulley", "wheel", "axle", "shaft",
    # Industrial shapes
    "pipe", "tube", "channel", "profile", "angle iron", "T-beam", "I-beam", "L-profile",
    # Containers
    "box without lid", "container with lid", "open box", "closed box", "cup", "bowl", "vase",
    # Grilles and lattices
    "grid", "mesh", "lattice", "honeycomb", "woven pattern", "cross pattern", "diamond pattern",
    # Spirals and curves
    "spiral staircase", "helix curve", "bezier curve", "wavy surface", "undulating shape",
    # Multiple components
    "two cubes", "cube and sphere", "stack of cylinders", "pyramid with base", "interlocking rings",
    # Mathematical shapes
    "torus knot", "klein bottle", "mobius strip", "trefoil knot", "figure eight", "lissajous curve",
    # Fractals
    "fractal tree", "fractal branch", "mandelbrot shape", "sierpinski triangle", "julia set",
    # Platonic solids
    "tetrahedron", "cube", "octahedron", "dodecahedron", "icosahedron",
    # Archimedean solids
    "truncated tetrahedron", "cuboctahedron", "truncated cube", "truncated octahedron",
    # Symmetrical patterns
    "symmetrical star", "radial pattern", "concentric rings", "radial lines", "symmetric flower",
    # Household items
    "mug", "cup", "fork", "spoon", "knife", "plate", "bowl", "glass", "bottle",
    # Tools
    "hammer", "wrench", "screwdriver", "pliers", "saw", "drill", "level",
    # Sports equipment
    "ball", "dice", "pyramid stack", "cone target", "ring target",
    # Puzzle pieces
    "puzzle piece", "interlocking piece", "puzzle connector", "puzzle cube",
    # Nature inspired
    "leaf", "tree", "branch", "coral", "shell", "nautilus", "snowflake", "crystal",
    # Abstract shapes
    "wave packet", "interference pattern", "checkerboard", "striped pattern", "gradient shape",
    # Geometric variations
    "chamfered cube", "rounded cube", "beveled cube", "sliced cube", "rotated cube",
    # Symmetry examples
    "bilateral symmetry", "radial symmetry", "rotational symmetry", "mirror symmetry",
    # Size variations
    "tiny cube", "small cube", "medium cube", "large cube", "huge cube", "giant cube",
    # Thickness variations
    "thick wall", "thin wall", "medium wall", "shell", "solid", "hollow",
    # Combination shapes
    "cube with pyramid", "sphere with cube", "cylinder with cone", "torus with sphere",
    # Boolean operations
    "union shape", "difference shape", "intersection shape", "cut shape",
    # Negative space
    "shape with cavity", "shape with indent", "hollowed out", "with negative space",
    # Layers
    "layered cube", "stacked spheres", "nested boxes", "concentric spheres", "layered rings",
    # Rotations
    "rotated square", "twisted shape", "spiral shape", "helical shape", "rotating pattern",
    # Scaling
    "scaled sphere", "scaled cylinder", "stretched cube", "compressed pyramid", "elongated shape",
    # Distortions
    "distorted cube", "warped sphere", "bent cylinder", "twisted torus", "skewed shape",
    # Special effects
    "glowing sphere", "light source", "shadow maker", "reflection", "transparent shape",
    # Tessellations
    "triangular tessellation", "square tessellation", "hexagonal tessellation", "complex tessellation",
    # Borders and frames
    "bordered cube", "framed shape", "outlined sphere", "hollow outline", "frame structure",
    # Connectors
    "connector piece", "joint", "socket", "plug", "coupling", "adapter", "bracket",
    # Mounting
    "mounting base", "mounting bracket", "attachment point", "pivot mount", "swivel mount",
    # Arrays and grids
    "cube array", "sphere array", "cylinder array", "mixed array", "irregular array",
    # Transformations
    "transformed cube", "matrix transformation", "composite shape", "hybrid shape",
    # Modular components
    "module", "unit cell", "repeating unit", "building block", "constructor piece",
]

# =============================================================================
# MODEL SETUP
# =============================================================================

def download_gguf_model(config):
    """Download Q8 GGUF model from Hugging Face"""
    model_config = config['model_config']
    hub_model_name = model_config['hub_model_name']
    base_model_name = hub_model_name.split('/')[-1]
    gguf_repo_name = f"{hub_model_name}-gguf"
    
    # Model filename
    model_filename = f"{base_model_name}-q8_0.gguf"
    
    print(f"🤖 Downloading GGUF model: {model_filename}")
    print(f"   Repository: {gguf_repo_name}")
    
    try:
        model_path = hf_hub_download(
            repo_id=gguf_repo_name,
            filename=model_filename,
            cache_dir="./models",
        )
        print(f"✓ Model downloaded to: {model_path}")
        return model_path
    except Exception as e:
        print(f"✗ Error downloading model: {e}")
        raise

def get_llama_cli_path():
    """Find llama-cli executable"""
    possible_paths = [
        "/home/riftuser/bob/llama.cpp/build/bin/llama-cli",
        os.path.expanduser("~/llama.cpp/build/bin/llama-cli"),
        os.path.join(os.getcwd(), "llama.cpp/build/bin/llama-cli"),
        "llama-cli",
    ]
    
    for path in possible_paths:
        if os.path.exists(path) and os.access(path, os.X_OK):
            print(f"✓ Found llama-cli at: {path}")
            return path
    
    raise Exception(
        "llama-cli not found. Please build llama.cpp:\n"
        "  cd ~/bob/llama.cpp && mkdir build && cd build\n"
        "  cmake .. && cmake --build . --config Release"
    )

# =============================================================================
# INFERENCE
# =============================================================================

def run_inference(model_path, object_name, llama_cli_path):
    """Run inference using llama-cli and extract token count"""
    prompt = f"hey cadmonkey, create me a {object_name}"
    
    print(f"  🎯 Generating: {object_name}")
    
    try:
        # Build command - simpler approach
        cmd = [
            llama_cli_path,
            "-m", model_path,
            "-n", "1024",
            "--temp", "0.7",
            "--top-p", "0.95",
            "-c", "1024",
        ]
        
        # Run with stdin for the prompt
        result = subprocess.run(
            cmd,
            input=prompt + "\n",
            capture_output=True,
            text=True,
            timeout=300  # 5 minute timeout
        )
        
        if result.returncode != 0:
            print(f"    ⚠ Return code: {result.returncode}")
            if result.stderr:
                print(f"    Error: {result.stderr[:300]}")
        
        # Extract token count from stderr (llama-cli outputs stats there)
        tokens_generated = 0
        if result.stderr:
            # Look for pattern like "tokens_evaluated = X" or similar
            import re
            match = re.search(r'(\d+)\s+(?:tokens?|t/s)', result.stderr)
            if match:
                try:
                    tokens_generated = int(match.group(1))
                except ValueError:
                    pass
        
        # If we couldn't extract from stderr, estimate from output length
        if tokens_generated == 0 and result.stdout:
            # Rough estimate: ~4 chars per token
            tokens_generated = len(result.stdout) // 4
        
        return result.stdout if result.stdout else None, tokens_generated
        
    except subprocess.TimeoutExpired:
        print(f"    ✗ Timeout (>300s) generating {object_name}")
        return None, 0
    except FileNotFoundError:
        print(f"    ✗ llama-cli not found at: {llama_cli_path}")
        return None, 0
    except Exception as e:
        print(f"    ✗ Error: {e}")
        return None, 0

# =============================================================================
# OPENSCAD CODE EXTRACTION
# =============================================================================

def extract_openscad_code(text):
    """Extract OpenSCAD code from the generated text"""
    if not text:
        return None
    
    # Try to find code blocks with markdown syntax
    markdown_pattern = r'```(?:scad|openscad)?\n(.*?)\n```'
    matches = re.findall(markdown_pattern, text, re.DOTALL)
    if matches:
        return matches[0]
    
    # Try to find raw OpenSCAD commands
    # Look for common OpenSCAD keywords
    scad_keywords = ['cube', 'sphere', 'cylinder', 'translate', 'rotate', 'scale', 'union', 'difference', 'intersection']
    
    lines = text.split('\n')
    scad_lines = []
    in_code = False
    
    for line in lines:
        # Start collecting if we find OpenSCAD keywords
        if any(keyword in line.lower() for keyword in scad_keywords):
            in_code = True
        
        if in_code:
            # Include lines that look like OpenSCAD code
            if line.strip() and (
                line.strip().startswith('//') or
                any(keyword in line for keyword in scad_keywords) or
                any(char in line for char in ['(', ')', '{', '}', '[', ']', ';'])
            ):
                scad_lines.append(line)
    
    if scad_lines:
        return '\n'.join(scad_lines)
    
    # If we can't find structured code, return the whole output
    # (sometimes models generate code without markdown formatting)
    if text.strip():
        return text
    
    return None

# =============================================================================
# RENDERING
# =============================================================================

def get_openscad_path():
    """Find OpenSCAD executable"""
    possible_paths = [
        "/usr/bin/openscad",
        "/snap/bin/openscad",
        os.path.expanduser("~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"),
        "openscad",
    ]
    
    for path in possible_paths:
        if os.path.exists(path) and os.access(path, os.X_OK):
            return path
    
    return None

def render_openscad(scad_code, object_name):
    """Render OpenSCAD code to STL/PNG"""
    openscad_path = get_openscad_path()
    
    if not openscad_path:
        print(f"    ⚠ OpenSCAD not found, skipping rendering")
        return False
    
    try:
        with tempfile.TemporaryDirectory() as tmpdir:
            scad_file = os.path.join(tmpdir, f"{object_name}.scad")
            output_file = os.path.join(tmpdir, f"{object_name}.stl")
            
            # Write OpenSCAD code to file
            with open(scad_file, 'w') as f:
                f.write(scad_code)
            
            # Render to STL using headless mode
            cmd = [
                openscad_path,
                "-o", output_file,
                "--export-format", "stl",
                scad_file
            ]
            
            print(f"    Running OpenSCAD render...")
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=120  # 2 minute timeout for complex renders
            )
            
            # Check if output file was created and has content
            if os.path.exists(output_file) and os.path.getsize(output_file) > 100:
                file_size = os.path.getsize(output_file)
                print(f"    ✓ Successfully rendered: {object_name} ({file_size} bytes)")
                return True
            else:
                print(f"    ✗ Render failed for {object_name}")
                if result.stderr:
                    stderr_msg = result.stderr[:300]
                    print(f"      Error: {stderr_msg}")
                if result.stdout:
                    print(f"      Output: {result.stdout[:300]}")
                return False
                
    except subprocess.TimeoutExpired:
        print(f"    ✗ OpenSCAD timeout (>60s) for {object_name}")
        return False
    except Exception as e:
        print(f"    ✗ Render error for {object_name}: {e}")
        return False

# =============================================================================
# EVALUATION
# =============================================================================

def evaluate_model(config):
    """Main evaluation function"""
    print("\n" + "="*60)
    print("🚀 MODEL EVALUATION - OpenSCAD Generation Test")
    print("="*60)
    
    # Get model path
    model_path = download_gguf_model(config)
    llama_cli_path = get_llama_cli_path()
    
    print(f"\n📋 Test Configuration:")
    print(f"   Objects to test: {len(TEST_OBJECTS)}")
    print(f"   Objects: {', '.join(TEST_OBJECTS)}")
    print()
    
    results = []
    
    for i, obj in enumerate(TEST_OBJECTS, 1):
        print(f"\n[{i}/{len(TEST_OBJECTS)}] Testing: {obj}")
        print("-" * 60)
        
        # Generate
        output, tokens_generated = run_inference(model_path, obj, llama_cli_path)
        
        if not output:
            results.append({
                'object': obj,
                'code_extracted': False,
                'render_success': False,
                'tokens_generated': 0,
            })
            continue
        
        # Extract code
        scad_code = extract_openscad_code(output)
        code_extracted = scad_code is not None and len(scad_code.strip()) > 0
        
        if code_extracted:
            print(f"  ✓ OpenSCAD code extracted ({len(scad_code)} chars, ~{tokens_generated} tokens)")
            
            # Try to render
            render_success = render_openscad(scad_code, obj)
        else:
            print(f"  ✗ Failed to extract OpenSCAD code")
            render_success = False
        
        results.append({
            'object': obj,
            'code_extracted': code_extracted,
            'render_success': render_success,
            'tokens_generated': tokens_generated,
        })
    
    # Print summary
    print("\n" + "="*60)
    print("📊 EVALUATION RESULTS")
    print("="*60)
    
    code_success = sum(1 for r in results if r['code_extracted'])
    render_success = sum(1 for r in results if r['render_success'])
    total = len(results)
    avg_tokens = sum(r['tokens_generated'] for r in results) / total if total > 0 else 0
    
    print(f"\n✨ Code Extraction Success Rate: {code_success}/{total} ({code_success/total*100:.1f}%)")
    print(f"🎨 Render Success Rate: {render_success}/{total} ({render_success/total*100:.1f}%)")
    print(f"📝 Average Tokens Generated: {avg_tokens:.0f}")
    
    print(f"\n{'Object':<30} {'Code':<6} {'Render':<8} {'Tokens':<8}")
    print("-" * 52)
    for r in results:
        code_status = "✓" if r['code_extracted'] else "✗"
        render_status = "✓" if r['render_success'] else "✗"
        print(f"{r['object']:<30} {code_status:<6} {render_status:<8} {r['tokens_generated']:<8}")
    
    # Save results to JSON
    results_file = f"evaluation_results_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    with open(results_file, 'w') as f:
        json.dump({
            'timestamp': datetime.now().isoformat(),
            'total_tests': total,
            'code_extraction_success': code_success,
            'code_extraction_rate': f"{code_success/total*100:.1f}%",
            'render_success': render_success,
            'render_success_rate': f"{render_success/total*100:.1f}%",
            'average_tokens_generated': f"{avg_tokens:.0f}",
            'results': results
        }, f, indent=2)
    
    print(f"\n💾 Results saved to: {results_file}")
    print("="*60)

# =============================================================================
# MAIN
# =============================================================================

if __name__ == "__main__":
    try:
        config = load_config()
        evaluate_model(config)
    except Exception as e:
        print(f"\n❌ Error: {e}")
        exit(1)
