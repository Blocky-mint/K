// Radial pattern generator in OpenSCAD
//
// Parameters:
//   radius: Radius of the circles in the pattern
//   width: Width of the pattern
//   height: Height of the pattern
//   num_rings: Number of rings in the pattern

module radial_pattern(radius, width, height, num_rings) {
  for (i = [0:num_rings-1]) {
    angle = i * 360 / num_rings;
    translate([radius * cos(angle), radius * sin(angle), height * i / num_rings]) {
      circle(r = radius * 0.5);
    }
  }
}

radial_pattern(radius = 10, width = 50, height = 40, num_rings = 10);