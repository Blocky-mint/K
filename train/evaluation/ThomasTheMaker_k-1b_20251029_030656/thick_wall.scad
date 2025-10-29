//Thickness of the wall

thickness = 10;

// Outer dimensions of the wall
outer_width = 50;
outer_height = 30;
outer_depth = 20;

// Inner dimensions of the wall
inner_width = outer_width - 2 * thickness;
inner_height = outer_height - 2 * thickness;
inner_depth = outer_depth - 2 * thickness;

// Create the thick wall
difference() {
  cube([outer_width, outer_height, outer_depth]);
  translate([0, 0, -0.1])
    cube([inner_width, inner_height, inner_depth]);
}