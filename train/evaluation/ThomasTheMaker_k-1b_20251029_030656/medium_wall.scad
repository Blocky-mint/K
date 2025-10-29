module wall(width, height, thickness, fillet_radius) {
  difference() {
    cube([width, height, thickness]);
    translate([fillet_radius, fillet_radius, 0])
    cube([width - 2*fillet_radius, height - 2*fillet_radius, thickness]);
  }
}

wall(width = 100, height = 200, thickness = 10, fillet_radius = 2);