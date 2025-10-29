$fn = 60;

radius = 50;
height = 20;

difference() {
  cylinder(h = height, r = radius);
  translate([0, 0, height])
  cylinder(h = 1, r = radius * 0.7);
}