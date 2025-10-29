module thin_wall(thickness, height, width) {
  difference() {
    cube([width, height, thickness]);
    translate([0, 0, -0.1]) cube([width, height, thickness + 0.2]);
  }
}

thin_wall(thickness = 0.5, height = 10, width = 20);