// Mug Parameters
mug_height = 100;
mug_diameter = 80;
mug_wall_thickness = 3;
handle_height = 40;
handle_width = 40;
handle_depth = 15;
handle_offset_x = 40;
handle_offset_y = 20;

// Cylinder for the mug body
difference() {
  cylinder(h = mug_height, d = mug_diameter, $fn = 100);
  cylinder(h = mug_height - 1, d = mug_diameter - 2 * mug_wall_thickness, $fn = 100);
}

// Handle
translate([handle_offset_x, handle_offset_y, mug_height - handle_height]) {
  cube([handle_width, handle_depth, handle_height]);
}