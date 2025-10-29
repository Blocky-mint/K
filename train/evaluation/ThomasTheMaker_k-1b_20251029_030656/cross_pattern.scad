module cross(width, height, depth, angle) {
  for (i = [0:width/angle - 1]) {
    translate([i * angle, 0, 0]) {
      cube([depth, width, depth]);
    }
  }
}

cross(width = 50, height = 50, depth = 50, angle = 45);