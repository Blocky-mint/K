// Mounting Base in OpenSCAD
// Parameters:
//   width: Width of the base
//   depth: Depth of the base
//   height: Height of the base
//   hole_diameter: Diameter of the mounting hole
//   hole_offset_x: Distance from edge to hole on x-axis
//   hole_offset_y: Distance from edge to hole on y-axis

module mounting_base(width, depth, height, hole_diameter, hole_offset_x, hole_offset_y) {
  difference() {
    cube([width, depth, height]);

    translate([hole_offset_x, hole_offset_y, 0])
    cylinder(h = height, r = hole_diameter / 2, $fn = 50);
    translate([width - hole_offset_x, depth - hole_offset_y, 0])
    cylinder(h = height, r = hole_diameter / 2, $fn = 50);

    translate([0,0,height/2])
    cube([width, depth, height]);

  }
}

mounting_base(width = 50, depth = 30, height = 10, hole_diameter = 6, hole_offset_x = 10, hole_offset_y = 10);