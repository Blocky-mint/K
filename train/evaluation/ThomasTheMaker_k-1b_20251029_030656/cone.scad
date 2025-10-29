module cone(h, r1, r2) {
  linear_extrude(height = h, convexity = 10)
  circle(r = r1 - r2);
}

cone(h = 10, r1 = 5, r2 = 0);