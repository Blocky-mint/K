// Tree Parameters
tree_height = 50;
trunk_radius = 5;
branch_angle = 30;
branch_length = 20;
branch_scale = 0.8;
num_branches = 10;
leaf_width = 10;
leaf_height = 20;

module fractal_branch(radius, height) {
  linear_extrude(height = height)
  polygon(points = [
    [radius, 0],
    [radius * 0.5, height],
    [radius * 0.8, height * 1.2],
    [radius * 0.9, height * 1.5],
    [radius * 0.7, height * 1.8],
    [radius * 0.6, height * 2],
    [radius * 0.5, height * 2.1],
    [radius * 0.4, height * 2.5],
    [radius * 0.3, height * 2.8],
    [radius * 0.2, height * 3],
    [radius * 0.1, height * 2.9],
    [radius * 0.05, height * 2.3]
  ]);
}

module tree() {
  difference() {
    union() {
      for (i = [1:num_branches]) {
        translate([i * (branch_length + trunk_radius) / (num_branches + 1) , 0, 0]) {
          branch(trunk_radius, branch_length);
        }
      }
    }
    
    translate([0, -1, 0]) {
      for (i = [1:num_branches]) {
        translate([i * (branch_length + trunk_radius) / (num_branches + 1) , -1, 0]) {
          branch(trunk_radius, branch_length);
        }
      }
    }
  }
}

translate([0, 0, 0]) tree();

// Leaf Placement
for (i = [1:num_branches]) {
  translate([i * (branch_length + trunk_radius) / (num_branches + 1) - leaf_width/2, 0, 0]) {
    rotate([0,0,i * 360/num_branches]) {
      linear_extrude(height = 5) {
        color("green")
        polygon(points = [
          [0, 0],
          [leaf_width, 0],
          [leaf_width * 0.5, 0.5],
          [0, 0.5]
        ]);
      }
    }
  }
}