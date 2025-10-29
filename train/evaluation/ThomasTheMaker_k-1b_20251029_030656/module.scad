// Module parameters
module my_module(width, height, depth, hole_diameter, hole_x, hole_y) {
  difference() {
    cube([width, height, depth]);
    translate([hole_x, hole_y, 0]) {
      cylinder(h=depth, r=hole_diameter/2, $fn=32);
    }
  }
}

my_module(width=50, height=30, depth=10, hole_diameter=8, hole_x=25, hole_y=10);