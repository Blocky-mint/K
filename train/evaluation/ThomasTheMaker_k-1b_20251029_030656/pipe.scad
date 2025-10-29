module pipe(height, diameter, wall_thickness) {
  cylinder(h = height, d = diameter, center = false);
}

pipe(height = 50, diameter = 20, wall_thickness = 2);