// Tree parameters
trunk_height = 50;
trunk_radius = 5;
branch_angle = 45;
branch_length = 20;
branch_radius_scale = 0.8;
branch_count = 8;

module trunk() {
  cylinder(h = trunk_height, r = trunk_radius);
}

module branch() {
  difference() {
    cylinder(h = branch_length, r = branch_radius_scale * trunk_radius);
    for (i = [0:branch_count-1]) {
      rotate([0, 0, i * 360 / branch_count]) {
        translate([0, 0, -branch_length * 0.5]) {
          cube([1, 0.1, 1], center = true);
        }
      }
    }
  }
}

module tree() {
  trunk();

  for (i = [0:branch_count-1]) {
    branch();
  }
}

tree();