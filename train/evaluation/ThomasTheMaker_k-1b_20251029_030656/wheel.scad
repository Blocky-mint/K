// Wheel parameters
radius = 50;
thickness = 10;
num_spokes = 6;
spoke_width = 5;
hole_radius = 5;

module wheel() {
  difference() {
    cylinder(h = thickness, r = radius, $fn = 100);
    translate([0, 0, -0.1])
    cylinder(h = thickness + 0.2, r = hole_radius, $fn = 100);
  }
}

wheel();