module box_with_holes(width, depth, height, hole_diameter, hole_radius) {
  difference() {
    cube([width, depth, height]);
    for (i = [0:1]) {
      for (j = [0:1]) {
        translate([width/2 - (i * hole_radius), depth/2 - (j * hole_radius), height/2 - (j * hole_radius)]) {
          cylinder(h = 1, r = hole_radius, $fn=50);
        }
      }
    }
  }
}

box_with_holes(width = 50, depth = 30, height = 20, hole_diameter = 10, hole_radius = 2);