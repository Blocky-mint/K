module rotated_cube(size, angle) {
  translate([size[0], size[1], size[2]]);
  rotate([angle, 0, 0])
    cube([size[0], size[1], size[2]]);
}

// Example usage:
rotated_cube(10, 45);