module brick(width, depth, height, wall_thickness, roundness) {
  difference() {
    cube([width, depth, height]);
    for (i = [0:roundness]) {
      translate([0, 0, 0])
        cylinder(r = (width / 2) - roundness * 0.5, h = height, $fn = 32);
    }
  }
}

brick(width = 50, depth = 30, height = 10, wall_thickness = 2, roundness = 1);