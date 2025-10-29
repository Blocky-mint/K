module dome(radius, height, segments) {
  hull() {
    for (i = [0:segments]) {
      angle = i * 360 / segments;
      x = radius * cos(angle);
      y = radius * sin(angle);
      
      translate([x, y, height / 2]) {
        sphere(r=radius/2);
      }
    }
  }
}

dome(radius = 50, height = 30, segments = 64);