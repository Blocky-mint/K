// Create a sphere with a cube as a difference
sphere_radius = 10;
cube_size = 20;

difference() {
  sphere(r = sphere_radius);
  translate([0, 0, -1]) cube([cube_size, cube_size, 2]);
}