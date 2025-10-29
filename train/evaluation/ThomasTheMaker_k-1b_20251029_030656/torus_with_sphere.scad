$fn = 60;

difference() {
  sphere(r = 1);
  translate([0,0,-1])
  cylinder(h=2, r=1, $fn = $fn);
}