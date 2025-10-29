module sphere(r) {
  linear_extrude(height = 1)
  circle(r = r);
}

sphere(r = 10);