module ring(radius, thickness, hole_radius) {
  difference() {
    cylinder(h = thickness, r = radius, $fn = 100);
    cylinder(h = thickness + 0.1, r = hole_radius, $fn = 100);
  }
}

ring(radius = 10, thickness = 2, hole_radius = 5);