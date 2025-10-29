// Puzzle Cube in OpenSCAD

// Parameters
cube_size = 20;
wall_thickness = 1.5;
rounding_radius = 1;
hole_diameter = 4;
hole_height = 1.5;
hole_offset_x = cube_size * 0.2;
hole_offset_y = cube_size * 0.2;

// Main cube
module puzzle_cube() {
  difference() {
    cube([cube_size, cube_size, cube_size]);
    translate([rounding_radius, rounding_radius, rounding_radius])
    cylinder(h = cube_size, r = rounding_radius, $fn = 50);
    translate([cube_size - rounding_radius, rounding_radius, rounding_radius])
    cylinder(h = cube_size, r = rounding_radius, $fn = 50);
    translate([rounding_radius, cube_size - rounding_radius, rounding_radius])
    cylinder(h = cube_size, r = rounding_radius, $fn = 50);
    translate([cube_size - rounding_radius, cube_size - rounding_radius, rounding_radius])
    cylinder(h = cube_size, r = rounding_radius, $fn = 50);
  }
}

// Holes
module holes() {
  translate([hole_offset_x, hole_offset_y, -0.1]) {
    cylinder(h = hole_height, r = hole_diameter / 2, $fn = 50);
  }
  translate([cube_size - hole_offset_x, cube_size - hole_offset_y, -0.1]) {
    cylinder(h = hole_height, r = hole_diameter / 2, $fn = 50);
  }
  translate([hole_offset_x, cube_size - hole_offset_y, -0.1]) {
    cylinder(h = hole_height, r = hole_diameter / 2, $fn = 50);
  }
  translate([cube_size - hole_offset_x, cube_size - hole_offset_y, -0.1]) {
    cylinder(h = hole_height, r = hole_diameter / 2, $fn = 50);
  }
}

// Render the puzzle cube
puzzle_cube();