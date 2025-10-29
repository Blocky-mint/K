module skewed_shape(width, height, depth, angle) {
  difference() {
    cube([width, height, depth]);
    rotate([0,0,angle])
    translate([0,0,-depth/2])
    cube([width, height, depth/2]);
  }
}

skewed_shape(width = 50, height = 50, depth = 20, angle = 20);