module scaled_cylinder(height, radius, scale_factor) {
  cylinder(h = height, r = radius, $fn = 50);
  translate([0, 0, height/scale_factor])
  scale([1, 1, scale_factor])
  cylinder(h = height, r = radius, $fn = 50);
}

scaled_cylinder(height = 20, radius = 10, scale_factor = 2);