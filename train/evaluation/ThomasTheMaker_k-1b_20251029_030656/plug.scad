// Plug Parameters
plug_diameter = 10;
plug_height = 20;
plug_wall_thickness = 1.5;
plug_tip_radius = 2;
plug_base_radius = 2;

// Plug Body
difference() {
  cylinder(h = plug_height, r = plug_diameter / 2, center = false);
  cylinder(h = plug_height + 0.1, r = plug_diameter / 2 - plug_wall_thickness, center = false);
}

// Plug Tip
translate([0, 0, plug_height]) {
  difference() {
    cylinder(h = 2, r = plug_tip_radius, center = false);
    cylinder(h = 2, r = plug_tip_radius - 0.5, center = false);
  }
}

// Plug Base
translate([0, 0, -plug_height]) {
  difference() {
    cylinder(h = 2, r = plug_base_radius, center = false);
    cylinder(h = 2, r = plug_base_radius - plug_wall_thickness, center = false);
  }
}