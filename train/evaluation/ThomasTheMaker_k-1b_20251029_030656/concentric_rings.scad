module concentric_rings(inner_radius, outer_radius, height, segments) {
  difference() {
    for (i = [0:segments]) {
      angle = i * 360 / segments;
      rotate([0,0,angle])
      translate([outer_radius, 0, 0])
      cylinder(r = outer_radius * cos(angle), h = height, $fn = segments);
    }
    translate([0,0,-1])
    cylinder(r = inner_radius, h = height + 2, $fn = segments);
  }
}

linear_extrude(height = height, slices = 100, $fn = 10000)
cylinder(r = outer_radius, h = height, $fn = 10000);

linear_extrude(height = height, slices = 100, $fn = 10000)
cylinder(r = inner_radius, h = height + 2, $fn = 10000);