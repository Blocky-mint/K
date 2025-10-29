module union(size, height, segments) {
  hull() {
    for (i = [0:segments]) {
      angle = i * 360 / segments;
      x = size[0] * cos(angle);
      y = size[1] * sin(angle);
      z = height * cos(angle);
      translate([x, y, z]) sphere(r=0.1);
    }
  }
}

union(size = 10, height = 1, segments = 32);