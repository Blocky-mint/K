module transform(x, y, z, scale) {
  translate([x, y, z * scale]) {
    cube([1, 1, 1]);
  }
}

// Example usage:
transform(0, 0, 0, 0.5);