// Cup parameters
cup_height = 100;
cup_diameter = 80;
wall_thickness = 2;
handle_height = 60;
handle_width = 20;
handle_depth = 20;

// Main cup body
difference() {
  cylinder(h = cup_height, d = cup_diameter, center = false);
  cylinder(h = cup_height - 10, d = cup_diameter - 2 * wall_thickness, center = false);
}

// Handle
translate([cup_diameter/2 + handle_width/2, -handle_height/2, cup_height - handle_height/2]) {
  cube([handle_width, handle_depth, handle_height]);
}