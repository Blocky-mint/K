module washer(outer_diameter, inner_diameter, thickness) {
  difference() {
    cylinder(h = thickness, r = outer_diameter / 2, center = false);
    cylinder(h = thickness, r = inner_diameter / 2, center = false);
  }
}

washer(outer_diameter = 50, inner_diameter = 25, thickness = 3);