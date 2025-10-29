$fn=50;

module frame(width, height, thickness, corner_radius) {
  difference() {
    cube([width, height, thickness]);
    translate([corner_radius, corner_radius, -0.1])
    cylinder(r=corner_radius, h=thickness + 0.2, $fn=50);
    translate([width - corner_radius, corner_radius, -0.1])
    cylinder(r=corner_radius, h=thickness + 0.2, $fn=50);
    translate([corner_radius, height - corner_radius, -0.1])
    cylinder(r=corner_radius, h=thickness + 0.2, $fn=50);
    translate([width - corner_radius, height - corner_radius, -0.1])
    cylinder(r=corner_radius, h=thickness + 0.2, $fn=50);
  }
}

frame(width = 100, height = 50, thickness = 5, corner_radius = 2);