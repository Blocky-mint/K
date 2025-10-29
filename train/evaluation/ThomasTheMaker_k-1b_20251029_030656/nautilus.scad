// Parameters for the nautilus
radius = 50;
height = 100;
turns = 15;
wall_thickness = 2;

module nautilus(radius, height, turns, wall_thickness) {
  linear_extrude(height = height, convexity = 10) {
    difference() {
      circle(r = radius, $fn = turns);
      translate([radius * 0.1, 0, 0]) {
        circle(r = radius * 0.5, $fn = turns);
      }
    }
    
    for (i = [0:turns - 1]) {
      rotate([0, 0, 360 * i / turns]) {
        translate([radius * 0.1, 0, 0]) {
          cylinder(h = height * i / turns, r = radius * 0.2, $fn = 30);
        }
      }
    }
  }
}

nautilus(radius, height, turns, wall_thickness);