module open_box(width, height, depth, wall_thickness) {
  difference() {
    cube([width, height, depth]);
    translate([wall_thickness, wall_thickness, wall_thickness]) {
      cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);
    }
  }
}

open_box(width = 100, height = 50, depth = 30, wall_thickness = 5);