// Mirror Symmetry parameters
radius = 50;
thickness = 2;
angle = 180;

// Main mirror
module mirror(radius, thickness) {
  difference() {
    cylinder(r = radius, h = thickness, $fn = 50);
    translate([0, 0, -1])
    cylinder(r = radius * 0.9, h = thickness * 1.1, $fn = 50);
  }
}

mirror(radius, thickness);