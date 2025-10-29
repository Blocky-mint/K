// Building Block Parameters
block_width = 50;
block_depth = 50;
block_height = 10;
corner_radius = 5;
wall_thickness = 3;

module building_block() {
  difference() {
    cube([block_width, block_depth, block_height]);
    translate([corner_radius, corner_radius, 0])
      cube([block_width - 2 * corner_radius, block_depth - 2 * corner_radius, block_height]);
  }
}

building_block();