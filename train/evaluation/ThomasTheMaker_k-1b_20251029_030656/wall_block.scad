// Wall Block in OpenSCAD

$fn = 32;

module wall_block(width, height, depth) {
  cube([width, height, depth]);
}

// Example usage:
wall_block(20, 10, 5);