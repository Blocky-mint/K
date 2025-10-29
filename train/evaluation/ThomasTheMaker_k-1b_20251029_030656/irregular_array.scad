module irregular_array(size, spacing, height) {
  for (i = [0:size-1]) {
    for (j = [0:size-1]) {
      translate([i * spacing, j * spacing, 0]) {
        cube([spacing, spacing, height]);
      }
    }
  }
}

irregular_array(20, 1, 5);