// Wrench Parameters
wrench_handle_length = 80;
wrench_handle_diameter = 25;
wrench_handle_wall_thickness = 3;
wrench_shaft_diameter = 30;
wrench_shaft_length = 100;
wrench_head_diameter = 35;
wrench_head_height = 20;
wrench_hole_diameter = 5;
hole_offset_x = 20;
hole_offset_y = 10;

// Handle
module wrench_handle() {
  difference() {
    cylinder(h = wrench_handle_length, d = wrench_handle_diameter, center = false);
    cylinder(h = wrench_handle_length - 2 * wrench_handle_wall_thickness, d = wrench_handle_diameter - 2 * wrench_handle_wall_thickness, center = false);
  }
}

// Shaft
module wrench_shaft() {
  difference() {
    cylinder(h = wrench_shaft_length, d = wrench_shaft_diameter, center = false);
    cylinder(h = wrench_shaft_length - 2 * wrench_handle_wall_thickness, d = wrench_shaft_diameter - 2 * wrench_handle_wall_thickness, center = false);
  }
}

// Head
module wrench_head() {
  difference() {
    cylinder(h = wrench_head_height, d = wrench_head_diameter, center = false);
    cylinder(h = wrench_head_height - 2 * wrench_handle_wall_thickness, d = wrench_shaft_diameter, center = false);
  }
}

// Hole
module wrench_hole() {
  cylinder(h = 1, d = wrench_hole_diameter, center = false);
}

// Assembly
union() {
  translate([0, 0, -wrench_handle_length/2]) wrench_handle();
  translate([0, 0, wrench_handle_length - wrench_shaft_length/2]) wrench_shaft();
  translate([0, 0, wrench_shaft_length - wrench_head_height/2]) wrench_head();
  translate([0, 0, wrench_shaft_length - wrench_head_height/2 + wrench_hole_offset_x, wrench_shaft_length - wrench_head_height/2 + wrench_hole_offset_y]) wrench_hole();
}