// Swivel Mount in OpenSCAD

// Parameters
arm_length = 50;
base_radius = 25;
base_height = 20;
hole_diameter = 8;
hole_offset_x = 10;
hole_offset_y = 10;
hole_depth = 5;

// Main Body
difference() {
  cylinder(h = base_height, r = base_radius, center = true);
  translate([0,0,-1]) cylinder(h = base_height + 2, r = base_radius - 2, center = true);
}

// Arm
translate([0, 0, base_height]) {
  cylinder(h = arm_length, r = base_radius / 2, center = true);
}

// Base
translate([0, 0, base_height + arm_length]) {
  difference() {
    cylinder(h = 5, r = base_radius, center = true);
    cylinder(h = 2, r = base_radius - 5, center = true);
  }
}

// Hole
translate([hole_offset_x, hole_offset_y, base_height]) {
  cylinder(h = 5, r = hole_diameter / 2, center = true);
}