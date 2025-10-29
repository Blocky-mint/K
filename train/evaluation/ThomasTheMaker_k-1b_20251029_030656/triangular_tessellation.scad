module triangular_tessellation(size, height) {
  for (i = [0:size-1:1; i < size-1]) {
    for (j = [0:size-1:size-1; j < size-1; j += 1)) {
      translate([size * (i - 1) / size, size * (j - 1) / size, height * (i - 1) / size]) {
        square([size, size]);
      }
    }
  }
}

// Example usage:  Adjust 'size' to control the size of the triangle.
size = 50;
height = 20;
tessellation(size, height);