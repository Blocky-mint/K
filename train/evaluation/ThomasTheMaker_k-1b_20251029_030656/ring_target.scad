$fn = 50;

radius = 20;
thickness = 3;
hole_radius = 10;

difference() {
  cylinder(r = radius, h = thickness, $fn = $fn);
  cylinder(r = hole_radius, h = thickness + 0.1, center = true);
}