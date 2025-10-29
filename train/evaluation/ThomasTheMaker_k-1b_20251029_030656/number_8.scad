module number_8(height=10, width=10, depth=10) {
  difference() {
    cube([width, depth, height]);
    translate([width/4, depth/4, height/4])
      cube([width/2, depth/2, height/2]);
  }
}

number_8();