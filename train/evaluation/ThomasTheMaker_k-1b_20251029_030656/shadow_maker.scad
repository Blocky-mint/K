// Shadow Maker Parameters
shadow_width = 50;
shadow_height = 75;
shadow_depth = 20;
wall_thickness = 3;
lamp_height = 60;
lamp_diameter = 25;
lamp_base_diameter = 20;
lamp_base_height = 10;

// Function to create a shadow piece
module shadow_piece(x, y, z) {
  translate([x, y, z]) {
    cube([shadow_width, shadow_height, shadow_depth]);
  }
}

// Main Body
difference() {
  cube([lamp_diameter + shadow_width, lamp_diameter + shadow_height, lamp_height]);

  // Subtract shadow pieces
  for (i = [0:5]) {
    for (j = [0:5]) {
      shadow_piece(i * shadow_width, j * shadow_height, 0);
    }
  }

  // Subtract base
  translate([0,0,-lamp_height/2]) {
    cylinder(h = lamp_height, r = lamp_base_diameter/2, $fn = 48);
  }

  // Subtract base (optional)
  translate([0,0,-lamp_height/2]) {
    cylinder(h = lamp_height, r = lamp_base_diameter/2, $fn = 48);
  }
}