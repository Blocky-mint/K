// Knife Parameters
handle_length = 80;
handle_width = 20;
handle_thickness = 5;
blade_length = 100;
blade_width = 25;
blade_thickness = 1;
blade_angle = 20; // Angle of the blade relative to the blade width

// Handle
module handle() {
  difference() {
    cube([handle_width, handle_length, handle_thickness]);
    translate([5, 5, 0])
      cube([handle_width - 10, handle_length - 10, handle_thickness - 1]);
  }
}

// Blade
module blade() {
  rotate([0, 0, blade_angle]) {
    linear_extrude(height = blade_thickness)
      polygon([
        [0, 0],
        [blade_length, 0],
        [blade_length - 0.5, blade_width],
        [0, blade_width]
      ]);
  }
}

// Combine Handle and Blade
union() {
  translate([0, 0, 0]) {
    handle();
    translate([0, handle_length, 0]) {
      blade();
    }
  }
}