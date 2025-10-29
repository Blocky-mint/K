// Socket parameters
radius = 20;
height = 30;
wall_thickness = 2;
hole_diameter = 10;
inner_radius = radius - wall_thickness;
inner_height = height - wall_thickness;

// Main body of the socket
difference() {
  cylinder(h = height, r = radius, center = false);
  translate([0, 0, -0.1])
    cylinder(h = height + 0.2, r = inner_radius, center = false);
}

// Hole in the socket
translate([0, 0, height/2])
rotate([0, 0, 0])
cylinder(h = 10, r = hole_diameter / 2, center = true);