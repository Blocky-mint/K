module cube_array(size, density = 1) {
  for (i = [0:density:size]) {
    for (j = [0:density:size]) {
      translate([i * size, j * size, 0]) {
        cube([size, size, size]);
      }
    }
  }
}

cube_array(10, 2);