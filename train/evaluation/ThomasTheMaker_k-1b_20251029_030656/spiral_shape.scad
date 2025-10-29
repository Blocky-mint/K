module spiral(radius, height, segments) {
  linear_extrude(height = height) {
    circle(r = radius);
  }
}

spiral(radius = 10, height = 5, segments = 48);