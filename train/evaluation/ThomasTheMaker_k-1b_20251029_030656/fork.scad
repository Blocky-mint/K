// Fork Parameters
fork_length = 80;
fork_width_handle = 20;
fork_width_tine = 10;
fork_tine_length = 50;
fork_tine_angle = 30;
fork_bowl_radius = 15;
fork_bowl_height = 15;

module fork() {
  difference() {
    union() {
      // Handle
      translate([0, 0, 0])
      cube([fork_width_handle, fork_width_handle, fork_length]);

      // Tines
      translate([fork_width_handle / 2, fork_width_handle / 2, fork_length - fork_tine_length])
      rotate([0, 0, fork_tine_angle])
      linear_extrude(height = fork_tine_length)
      polygon([
          [0, 0],
          [fork_width_tine / 2, fork_bowl_radius],
          [0, 0]
      ]);

      translate([0, -fork_width_handle / 2, fork_length - fork_tine_length])
      rotate([0, 0, -fork_tine_angle])
      linear_extrude(height = fork_tine_length)
      polygon([
          [0, 0],
          [fork_width_tine / 2, fork_bowl_radius],
          [0, 0]
      ]);
    }

    // Bowl
    translate([0, 0, fork_length - fork_bowl_height])
    rotate([0, 0, 90])
    cylinder(h = fork_bowl_height, r = fork_bowl_radius);
  }
}

fork();