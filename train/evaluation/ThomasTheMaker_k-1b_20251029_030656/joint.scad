// Joint parameters
joint_radius = 10;
joint_height = 20;
joint_width = 10;
hole_diameter = 2;
wall_thickness = 1;

difference() {
  cylinder(h = joint_height, r = joint_radius, $fn = 100);
  translate([0, 0, -0.1])
  cylinder(h = joint_height + 0.2, r = hole_diameter / 2, $fn = 100);
}