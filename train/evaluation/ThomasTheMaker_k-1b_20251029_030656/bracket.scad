module bracket(width, height, thickness, hole_diameter, hole_distance) {
  difference() {
    cube([width, height, thickness]);
    translate([hole_distance, height/2, -0.1])
    cylinder(h=thickness + 0.1, r=hole_diameter/2, $fn=50);
    translate([width - hole_distance, height/2, -0.1])
    cylinder(h=thickness + 0.1, r=hole_diameter/2, $fn=50);
  }
}

bracket(width = 50, height = 20, thickness = 5, hole_diameter = 4, hole_distance = 15);