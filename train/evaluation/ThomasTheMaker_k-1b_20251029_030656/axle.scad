// Axle parameters
diameter = 8;
length = 50;
hole_diameter = 2;

difference() {
  cylinder(h = length, d = diameter);
  cylinder(h = length + 1, d = hole_diameter);
}