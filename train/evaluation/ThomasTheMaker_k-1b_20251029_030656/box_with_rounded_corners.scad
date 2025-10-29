// Parameters
box_width = 50;
box_height = 50;
box_depth = 50;
radius = 10;

// Rounded corners
module rounded_cube(width, height, depth, radius) {
  hull() {
    translate([0, 0, 0]) sphere(r = radius);
    translate([width, 0, 0]) sphere(r = radius);
    translate([0, height, 0]) sphere(r = radius);
    translate([width, height, 0]) sphere(r = radius);
    translate([0, 0, depth]) sphere(r = radius);
    translate([width, 0, depth]) sphere(r = radius);
    translate([0, height, depth]) sphere(r = radius);
    translate([width, height, depth]) sphere(r = radius);
    translate([0, 0, 0]) sphere(r = radius);
    translate([width, 0, 0]) sphere(r = radius);
    translate([0, height, 0]) sphere(r = radius);
    translate([width, height, 0]) sphere(r = radius);
    translate([0, 0, depth]) sphere(r = radius);
    translate([width, 0, depth]) sphere(r = radius);
    translate([0, height, depth]) sphere(r = radius);
    translate([width, height, depth]) sphere(r = radius);
    translate([0, 0, 0]) sphere(r = radius);
    translate([width, 0, 0]) sphere(r = radius);
    translate([0, height, 0]) sphere(r = radius);
    translate([width, height, 0]) sphere(r = radius);
    translate([0, 0, depth]) sphere(r = radius);
    translate([width, 0, depth]) sphere(r = radius);
    translate([0, height, depth]) sphere(r = radius);
    translate([width, height, depth]) sphere(r = radius);
    translate([0, 0, 0]) sphere(r = radius);
    translate([width, 0, 0]) sphere(r = radius);
    translate([0, height, 0]) sphere(r = radius);
    translate([width, height, 0]) sphere(r = radius);
    translate([0, 0, depth]) sphere(r = radius);
    translate([width, 0, depth]) sphere(r = radius);
    translate([0, height, depth]) sphere(r = radius);
    translate([width, height, depth]) sphere(r = radius);
    translate([0, 0, 0]) sphere(r = radius);
    translate([width, 0, 0]) sphere(r = radius);
    translate([0, height, 0]) sphere(r = radius);
    translate([width, height, 0]) sphere(r = radius);
    translate([0, 0, depth]) sphere(r = radius);
    translate([width, 0, depth]) sphere(r = radius);
    translate([0, height, depth]) sphere(r = radius);
    translate([width, height, depth]) sphere(r = radius);
    translate([0, 0, 0]) sphere(r = radius);
    translate([width, 0, 0]) sphere(r = radius);
    translate([0, height, 0]) sphere(r = radius);
    translate([width, height, 0]) sphere(r = radius);
    translate([0, 0, depth]) sphere(r = radius);
    translate([width, 0, depth]) sphere(r = radius);
    translate([0, height, depth]) sphere(r = radius);
    translate([width, height, depth]) sphere(r = radius);
  }

  rounded_cube(width, height, depth, radius);
}

rounded_cube(box_width, box_height, box_depth, radius);