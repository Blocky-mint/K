module lissajous_curve(radius, height, segments) {
  linear_extrude(height = height, convexity = 10)
  for (i = [0:segments-1]) {
    angle = i * 360 / segments;
    x = radius * cos(angle);
    y = radius * sin(angle);
  }
}

lissajous_curve(radius = 10, height = 2, segments = 30);