$fn = 64;

module composite_shape(width, height, depth, thickness, hole_diameter, hole_x, hole_y, hole_z) {
  difference() {
    cube([width, height, depth]);
    translate([width/4, height/4, depth/4])
    cylinder(h=thickness, r=hole_diameter/2);
  }
}

composite_shape(width=50, height=40, depth=30, thickness=5, hole_diameter=8, hole_x=20, hole_y=20, hole_z=10);