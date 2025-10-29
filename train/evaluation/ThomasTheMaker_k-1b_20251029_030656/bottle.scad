// Parameters for the bottle
neck_height = 50;
neck_diameter = 15;
body_height = 100;
body_diameter = 60;
body_wall_thickness = 3;
base_diameter = 40;
base_height = 20;
base_wall_thickness = 2;

// Calculate inner dimensions
neck_height_inner = neck_height - neck_height;
neck_diameter_inner = neck_diameter * 0.7;
body_height_inner = body_height - body_height;
body_diameter_inner = body_diameter * 0.7;
base_diameter_inner = base_diameter * 0.7;
base_height_inner = base_height - base_height;

module bottle() {
    // Body
    difference() {
        cylinder(h = body_height, d = body_diameter, center = false);
        translate([0, 0, body_height/2])
        cylinder(h = body_height/4, d = body_diameter - 2*body_wall_thickness, center = false);
    }

    // Neck
    cylinder(h = neck_height, d = neck_diameter, center = false);

    // Base
    difference() {
        cylinder(h = base_height, d = base_diameter, center = false);
        translate([0, 0, base_height/2])
        cylinder(h = base_height/4, d = base_diameter - 2*base_wall_thickness, center = false);
    }

    // Cap (optional - adds complexity and might require more rounding)
    // This example removes it for simplicity.
    //translate([0,0,body_height])
    //difference(){
    //    cylinder(h = neck_height - body_height - 10, d = neck_diameter, center = false);
    //    cylinder(h = body_height - 20, d = neck_diameter - 2*body_wall_thickness, center = false);
    //}
}

bottle();