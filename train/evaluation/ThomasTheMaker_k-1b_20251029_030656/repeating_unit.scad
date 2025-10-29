// Repeating unit parameters
radius = 20;
width = 5;
height = 5;
segments = 16;

difference() {
  // Outer circle
  cylinder(r = radius, h = height, $fn = segments);

  // Inner circle (to create the repeating element)
  translate([0,0,-1])
  cylinder(r = radius - 1.5, h = height + 1, $fn = segments);

  // Offset the center for repetition
  translate([0,0,0])
  sphere(r = 1, $fn = segments);
}