module hollow_box(width, depth, height, wall_thickness) {
  difference() {
    cube([width, depth, height]);
    translate([wall_thickness, wall_thickness, wall_thickness]) {
      cube([width - 2 * wall_thickness, depth - 2 * wall_thickness, height - 2 * wall_thickness]);
    }
  }
}

hollow_box(width = 100, depth = 50, height = 100, wall_thickness = 5);