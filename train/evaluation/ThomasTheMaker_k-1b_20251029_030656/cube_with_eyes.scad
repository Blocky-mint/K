// Parameters
cube_size = 20;
eye_radius = 3;
eye_offset_x = cube_size * 0.2;
eye_offset_y = cube_size * 0.2;
eye_offset_z = cube_size * 0.2;

difference() {
  cube([cube_size, cube_size, cube_size]);

  translate([eye_offset_x, eye_offset_y, eye_offset_z])
  sphere(eye_radius);
}