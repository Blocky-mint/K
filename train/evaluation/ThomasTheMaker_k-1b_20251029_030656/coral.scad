// Coral model in OpenSCAD

// Parameters
radius = 10;
height = 20;
branch_angle = 15;
branch_length = 20;
branch_radius = 1;
num_branches = 10;

module coral(radius, height, branch_angle, branch_length, branch_radius, num_branches) {
  for (i = [0:num_branches-1]) {
    rotate([0, branch_angle, 0]) {
      translate([radius * cos(i * branch_angle), radius * sin(i * branch_angle), height * i / num_branches]) {
        cylinder(h = branch_length, r = branch_radius, $fn=32);
      }
    }
  }
}

coral(radius, height, branch_angle, branch_length, branch_radius, num_branches);