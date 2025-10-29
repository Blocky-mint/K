// Puzzle Piece Generator - OpenSCAD Code

// Parameters
piece_width = 20;
piece_height = 30;
hole_diameter = 5;
rounding_radius = 1;
corner_fillet_radius = 1;

module puzzle_piece(width, height, hole_diameter, rounding_radius, corner_fillet_radius) {
  difference() {
    union() {
      // Main body
      translate([-width/2, -height/2])
        cube([width, height, 0.1]);

      // Rounded corners
      for (i = [0, 1, 2, 3]) {
        rotate([0,0,i * 90])
          translate([0, 0, 0])
            cylinder(r = rounding_radius, h = 0.2, $fn=32);
      }

      // Hole
      translate([-width/2, -height/2 - hole_diameter/2, 0])
        cylinder(h = height + 0.1, r = hole_diameter/2, $fn=32);
    }
    
    //Cut out for the rounded shape
    translate([-width/2, -height/2 - 0.1, -0.1])
    cube([width, height, 0.2]);
  }
}

puzzle_piece(piece_width, piece_height, hole_diameter, rounding_radius, corner_fillet_radius);