module spiral(radius, height, segments) {
  linear_extrude(height = height, convexity = 10, $fn = segments)
  circle(r = radius);
}

spiral(radius = 50, height = 10, segments = 50);