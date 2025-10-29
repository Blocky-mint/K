module solid(length, width, height, fillet_radius) {
  hull() {
    translate([0, 0, 0]) sphere(r = fillet_radius);
    translate([length, 0, 0]) sphere(r = fillet_radius);
    translate([0, width, 0]) sphere(r = fillet_radius);
    translate([length, width, 0]) sphere(r = fillet_radius);
    translate([0, 0, height]) sphere(r = fillet_radius);
    translate([length, 0, height]) sphere(r = fillet_radius);
    translate([0, width, height]) sphere(r = fillet_radius);
    translate([length, width, height]) sphere(r = fillet_radius);
  }
}

solid(length = 50, width = 25, height = 10, fillet_radius = 2);