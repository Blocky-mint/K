module crystal(radius, height, facets, angle_offset) {
  // Calculate the radius for the basic crystal shape
  radius = radius * cos(angle_offset);

  // Calculate the height of a single facet
  facet_height = radius * 1.5 * tan(2 * angle_offset);

  // Create a sphere for each facet
  for (i = [0:facets - 1]) {
    rotate([0, 0, i * 360 * (facets + 1) / facets]) {
      translate([radius, 0, 0]) {
        cylinder(h = facet_height, r = 1.5, $fn = 48);
      }
    }
  }
}

// Example Usage:
crystal(radius = 20, height = 10, facets = 20, angle_offset = 30);