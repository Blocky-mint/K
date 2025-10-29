// Level parameters
level_height = 10;
level_width = 50;
level_depth = 20;
level_radius = 2;

difference() {
  // Main level body
  cylinder(h = level_height, r = level_radius, $fn = 64);

  // Rim
  translate([0,0,-level_depth/2])
  cylinder(h = level_height, r = level_radius, $fn = 64);

  // Center hole
  translate([0,0,0])
  cylinder(h = level_height, r = level_radius * 0.75, $fn = 64);
}