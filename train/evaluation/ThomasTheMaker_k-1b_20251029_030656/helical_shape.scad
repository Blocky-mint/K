module helical(radius, height, angle, segments) {
  rotate_extrude(angle = angle, convexity = 10)
  translate([radius, 0, 0])
  circle(r = radius, $fn = segments);
}

// Example usage:
helixical_shape(radius = 10, height = 20, angle = 45, segments = 60);