// Torus Knot Parameters
radius_top = 10;
radius_bottom = 8;
height = 2;
resolution = 50;

module torus_knot(radius_top, radius_bottom, height, resolution) {
  rotate_extrude(angle = 2 * PI)
  translate([radius_top, 0, 0])
  circle(r = radius_bottom, $fn = resolution);
}

torus_knot(radius_top, radius_bottom, height, resolution);