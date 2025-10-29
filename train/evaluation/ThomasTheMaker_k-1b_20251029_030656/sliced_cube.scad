module sliced_cube(size, slices, slice_size) {
  difference() {
    cube([size, size, size]);
    for (i = [0:slices-1]) {
      translate([i * slice_size, 0, 0]) {
        cube([size, size, size]);
      }
    }
  }
}

sliced_cube(20, 10, 2);