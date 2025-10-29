// Saw parameters
saw_width = 50;
saw_height = 20;
saw_depth = 10;
blade_angle = 30; // Degrees from vertical
blade_width = 15;
blade_height = 5;
handle_width = 25;
handle_height = 30;
handle_depth = 20;

module saw() {
  difference() {
    cube([saw_width, saw_height, saw_depth]);
    
    // Cut out the blade
    translate([0, saw_height - blade_height, 0])
    rotate([0, 0, blade_angle])
    cube([blade_width, blade_height, blade_width]);

    // Cut out the handle
    translate([0, saw_height - handle_height, 0])
    cube([handle_width, handle_height, handle_depth]);
  }
}

saw();