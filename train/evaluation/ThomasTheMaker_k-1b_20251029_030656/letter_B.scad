module b(height=20, width=25, depth=10) {
  difference() {
    cube([width, depth, height]);
    translate([width/4, depth/4, 0])
    rotate([0, 90, 0])
    cylinder(h=height, r=width/4, $fn=32);
    translate([width/4, depth/4, 0])
    rotate([0, 90, 0])
    cylinder(h=height, r=depth/4, $fn=32);
  }
}

b();