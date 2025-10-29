$fn = 32;

module hollowed_cylinder(h, r1, r2, thickness) {
  difference() {
    cylinder(h = h, r = r1);
    translate([0, 0, -thickness/2])
      cylinder(h = h + thickness, r = r2);
  }
}

hollowed_cylinder(h = 20, r1 = 5, r2 = 2, thickness = 1);