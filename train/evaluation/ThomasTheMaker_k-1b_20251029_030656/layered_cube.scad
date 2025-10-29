module cube(size, layers) {
  for (i = [0:layers-1]) {
    translate([i * size, 0, 0]) {
      cube(size);
    }
  }
}

cube(10, 3);