module hollow_cylinder(h, r1, r2, z_offset) {
  difference() {
    cylinder(h = h, r = r1, center = false);
    translate([0, 0, z_offset])
    cylinder(h = h - z_offset, r = r2, center = false);
  }
}

hollow_cylinder(h = 10, r1 = 5, r2 = 2, z_offset = 1);