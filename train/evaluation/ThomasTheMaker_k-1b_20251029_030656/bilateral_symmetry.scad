module bilateral_symmetry(width, height, depth, offset) {
  difference() {
    cube([width, height, depth]);
    translate([offset, offset, offset]) {
      cube([width - 2 * offset, height - 2 * offset, depth - 2 * offset]);
    }
  }
}

bilateral_symmetry(width = 50, height = 50, depth = 50, offset = 0);