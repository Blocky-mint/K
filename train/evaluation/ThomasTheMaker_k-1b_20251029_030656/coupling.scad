// Coupling Parameters
inner_diameter = 10;
outer_diameter = 20;
length = 20;
wall_thickness = 2;

// Create the inner cylinder
module inner_cylinder(diameter, height) {
    cylinder(h = height, d = diameter);
}

// Create the outer cylinder
module outer_cylinder(diameter, height) {
    cylinder(h = height, d = diameter);
}

// Combine the inner and outer cylinders
difference() {
    outer_cylinder(outer_diameter, length);
    translate([0, 0, -wall_thickness/2])
    inner_cylinder(inner_diameter, length);
}