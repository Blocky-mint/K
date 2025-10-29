$fn = 100;

module puzzle_connector(width, height, depth, hole_diameter, hole_distance) {
  difference() {
    cube([width, height, depth]);
    
    translate([hole_distance, hole_distance, hole_distance])
    cube([width - 2 * hole_distance, height - 2 * hole_distance, depth - 2 * hole_distance]);
  }
}

puzzle_connector(width = 50, height = 30, depth = 20, hole_diameter = 8, hole_distance = 10);