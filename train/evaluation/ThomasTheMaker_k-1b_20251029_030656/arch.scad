module arch(width, height, depth, radius, segments = 32) {
  difference() {
    hull() {
      for (i = [0:segments]) {
        angle = i * 360 / segments;
        translate([cos(angle) * width / 2, sin(angle) * height / 2, 0])
        rotate([0, 0, angle])
        cube([width, height, depth]);
      }
    }

    // Cut out the arch shape
    translate([0, 0, -0.1])
    cube([width, height, depth + 0.2], center = true);
  }
}

arch(width = 50, height = 30, depth = 20, radius = 15);