module o(height = 10, width = 20, depth = 10) {
  difference() {
    cube([width, depth, height]);
    translate([width/4, depth/4, 0])
    cube([width/2, depth/2, height + 1]);
  }
}

o();