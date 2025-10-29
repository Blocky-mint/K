module prism(width, height, depth, angle) {
  difference() {
    cube([width, height, depth]);
    translate([0, 0, -depth * tan(angle)])
    cube([width, height, depth]);
  }
}

square_prism(width = 20, height = 30, depth = 20, angle = 30);