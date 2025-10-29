module connector(width, height, depth, hole_diameter, hole_distance) {
  difference() {
    cube([width, height, depth]);
    translate([hole_distance, hole_distance, -0.1])
    cylinder(h = depth + 0.2, r = hole_diameter / 2, $fn = 32);
    translate([width - hole_distance, height - hole_distance, -0.1])
    cylinder(h = depth + 0.2, r = hole_diameter / 2, $fn = 32);
  }
}

connector(width = 50, height = 30, depth = 20, hole_diameter = 8, hole_distance = 15);