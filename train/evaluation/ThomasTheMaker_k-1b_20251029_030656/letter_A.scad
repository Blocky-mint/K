$fn = 60;

module a(height = 20, width = 50, depth = 10) {
  difference() {
    cube([width, depth, height]);
    translate([width/4, depth/4, height/4])
    rotate([90,0,0])
    cube([width/2, depth/2, height/2]);
  }
}

a(height = 20, width = 50, depth = 10);