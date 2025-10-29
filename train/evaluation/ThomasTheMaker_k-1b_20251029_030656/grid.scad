module grid(rows, cols, spacing) {
  for (i = [0:rows-1]) {
    for (j = [0:cols-1]) {
      translate([i * spacing, j * spacing, 0]) {
        cube([1, 1, 1]);
      }
    }
  }
}

grid(5, 4, 1);