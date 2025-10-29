// Hook Parameters
hook_length = 50;
hook_width = 15;
hook_height = 10;
hook_radius = 3;
wall_thickness = 1;

difference() {
  // Main Body
  cube([hook_length, hook_width, hook_height]);

  // Rounding
  for (i = [0:3]) {
    for (j = [0:3]) {
      translate([i * hook_length, j * hook_width, 0]) {
        cylinder(r = hook_radius, h = 1, $fn = 24);
      }
    }
  }

  //Fillets for grip
  translate([hook_length - hook_radius, 0, 0])
  cube([hook_radius * 2, hook_width, hook_height]);
}