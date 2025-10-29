$fn = 50;

module sphere(r) {
  sphere(r);
}

module cube(size) {
  cube(size);
}

difference() {
  sphere(10);
  translate([0,0,-0.1]) cube([20,20,20]);
}