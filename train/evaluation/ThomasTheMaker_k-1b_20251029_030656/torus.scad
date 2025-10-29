module torus(major_radius, minor_radius, $fn=50) {
  rotate_extrude(convexity = 10)
  translate([major_radius, 0, 0])
  circle(r = minor_radius);
}

torus(major_radius = 10, minor_radius = 2, $fn = 50);