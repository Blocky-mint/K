module piece(width, height, depth, fillet_radius) {
  difference() {
    cube([width, height, depth]);
    translate([fillet_radius, fillet_radius, fillet_radius])
    cube([width - 2 * fillet_radius, height - 2 * fillet_radius, depth - 2 * fillet_radius]);
  }
}

piece(width = 50, height = 30, depth = 20, fillet_radius = 3);