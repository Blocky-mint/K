// Parameters
diameter = 10;  // Diameter of the shaft
length = 50;     // Length of the shaft
wall_thickness = 2; // Thickness of the shaft wall
taper_angle = 15; // Angle of the taper at the top

// Calculate inner diameter
inner_diameter = diameter - (2 * wall_thickness);

// Create the shaft
difference() {
    cylinder(h = length, d = diameter, center = false);
    cylinder(h = length, d = inner_diameter, center = false);
}

// Tapered top (optional)
//translate([0, 0, length])
//rotate([0, 0, 90])
//linear_extrude(height = wall_thickness)
//polygon(points=[[0, 0], [inner_diameter/2, 0]]);