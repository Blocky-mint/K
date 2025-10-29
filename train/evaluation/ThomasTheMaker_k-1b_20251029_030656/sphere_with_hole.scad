module sphere(r) {
  translate([0,0,r]) sphere(r);
}

module cylinder_with_hole(h, r_inner, r_outer) {
  cylinder(h = h, r = r_outer, center = false);
}

difference() {
  sphere(r = 10);
  cylinder_with_hole(h = 2, r_inner = 5, r_outer = 12);
}