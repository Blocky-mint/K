// Mounting Bracket

// Parameters
thickness = 3;
width = 50;
height = 20;
hole_diameter = 5;
hole_offset_x = 10;
hole_offset_y = 10;

module mounting_bracket() {
  difference() {
    cube([width, height, thickness]);
    
    // Holes for mounting
    translate([hole_offset_x, hole_offset_y, 0])
      cylinder(h = thickness, r = hole_diameter / 2, $fn = 32);
    translate([width - hole_offset_x, hole_offset_y, 0])
      cylinder(h = thickness, r = hole_diameter / 2, $fn = 32);
    translate([hole_offset_x, height - hole_offset_y, 0])
      cylinder(h = thickness, r = hole_diameter / 2, $fn = 32);
    translate([width - hole_offset_x, height - hole_offset_y, thickness])
      cylinder(h = thickness, r = hole_diameter / 2, $fn = 32);
  }
}

mounting_bracket();