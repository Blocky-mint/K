// Snowflake parameters
num_flakes = 100;
flake_size = 5;
flake_height = 3;
point_count = 10;
point_angle = 360 / point_count;
point_offset = 1;

module snowflake_flake(x, y, z) {
  translate([x, y, z]) {
    union() {
      for (i = [0:point_count]) {
        angle = i * point_angle;
        z_offset = (i * point_offset) * 0.5;

        // Color based on number of points
        color_scale = 0.3;
        color_map(0, 1, 2) {
          color(i, 0, 0) = [1, 0, 1]; // Red
          color(i, 1, 1) = [0.8, 0.2, 0.2]; // Blue
          color(i, 2, 2) = [0.1, 0.1, 0.1]; // Green
        }
        
        // Snowflake shape
        for (j = [0:num_flakes - 1]) {
          rotate([0, 0, j * 180 - 120]) {
            scale([1,1,1]) {
              translate([0, 0, z_offset]) {
                cube([flake_size, flake_size, flake_height]);
              }
            }
          }
        }
      }
    }
  }
}

// Main snowflake assembly
difference() {
  for (i = [0:num_flakes - 1]) {
    snowflake_flake(i, i * 5, i * 5);
  }
}