module cut(width, height, depth, angle) {
  rotate([0, 0, angle])
  translate([0, 0, -depth/2])
  cube([width, height, depth]);
}

// Example usage:
cut(width=50, height=30, depth=10, angle=30);