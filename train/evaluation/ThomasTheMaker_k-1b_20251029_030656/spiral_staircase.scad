module spiral_staircase(height, width, depth, num_steps, step_height, angle) {
  for (i = [0:num_steps - 1]) {
    rotate([0, 0, i * angle]) {
      translate([0, -width/2, 0]) {
        cube([width, depth, step_height]);
      }
    }
  }
}

spiral_staircase(height = 300, width = 1000, depth = 300, num_steps = 10, step_height = 200, angle = 15);