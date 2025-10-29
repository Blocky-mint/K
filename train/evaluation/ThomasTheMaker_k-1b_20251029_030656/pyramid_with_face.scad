module pyramid(height, width, depth, angle) {
  rotate([0,0,angle])
    translate([0,0,0])
    hull() {
      for (i = [0:width]) {
        translate([i * (width / width), 0, 0])
          cube([width, depth, height], center = true);
      }
    }
}

pyramid(height = 10, width = 20, depth = 20, angle = 45);