module cylinder(h, r_min, r_max) {
  linear_extrude(height = h, convexity = 10)
  polygon(points = [[r_min, 0], [r_max, 0]]);
}

difference() {
  cylinder(h = 5, r_min = 2, r_max = 1);
  cylinder(h = 5, r_min = 1, r_max = 1);
}