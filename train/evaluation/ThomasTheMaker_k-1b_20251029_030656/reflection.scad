module reflection(width, height, depth, angle, center) {
  difference() {
    cube([width, height, depth]);
    translate([0, 0, -0.1])
      rotate([0, 0, angle])
        cube([width, height, depth]);
  }
}

// Example usage:
reflection(width = 100, height = 100, depth = 100, angle = 45, center = false);