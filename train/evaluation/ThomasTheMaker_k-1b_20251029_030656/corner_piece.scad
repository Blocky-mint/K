module corner_piece(width, depth, height, radius) {
  difference() {
    cube([width, depth, height]);
    translate([radius, radius, height - radius])
    cylinder(h = radius, r = radius, $fn = 32);
    translate([width - radius, radius, height - radius])
    cylinder(h = radius, r = radius, $fn = 32);
    translate([radius, depth - radius, height - radius])
    cylinder(h = radius, r = radius, $fn = 32);
    translate([width - radius, depth - radius, height - radius])
    cylinder(h = radius, r = radius, $fn = 32);
  }
}

corner_piece(width = 20, depth = 10, height = 5, radius = 2);