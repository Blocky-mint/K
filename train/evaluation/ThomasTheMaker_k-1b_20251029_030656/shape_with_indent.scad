module indent(width, height, depth, angle) {
  difference() {
    cube([width, height, depth]);
    translate([width/2 - 1, height/2 - 1, depth/2 - 1])
    rotate([0, angle, 0])
    cylinder(h=depth, r=1, $fn=64);
    translate([width/2 + 1, height/2 + 1, depth/2 + 1])
    rotate([0, angle, 0])
    cylinder(h=depth, r=1, $fn=64);
  }
}

indent(width=50, height=30, depth=20, angle=30);