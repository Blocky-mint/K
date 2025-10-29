module cube_tower(height, width, depth, rounds = 2) {
  difference() {
    cube([width, depth, height]);
    for (i = [0:height-1]) {
      translate([0, 0, i]) {
        cylinder(r = rounds, h = 1, center = false);
      }
    }
  }
}

cube_tower(height = 50, width = 100, depth = 100, rounds = 4);