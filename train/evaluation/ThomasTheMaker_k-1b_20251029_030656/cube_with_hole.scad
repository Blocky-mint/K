module cube(size, hole_radius) {
  difference() {
    cube([size, size, size]);
    translate([size/2, size/2, size/2])
    cylinder(h=size, r=hole_radius, $fn=50);
  }
}

cube([10, 10, 10], 1);