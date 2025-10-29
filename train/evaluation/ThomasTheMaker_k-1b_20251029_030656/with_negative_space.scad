module with_negative_space(width, depth, height, spacing) {
  difference() {
    cube([width, depth, height]);
    translate([spacing, spacing, spacing])
    cube([width - 2 * spacing, depth - 2 * spacing, height - 2 * spacing]);
  }
}

with_negative_space(width = 50, depth = 30, height = 20, spacing = 5);