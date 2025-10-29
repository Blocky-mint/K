module checkerboard(size_x, size_y) {
  difference() {
    cube([size_x, size_y, 1]);
    
    for (x = [0:size_x-1]) {
      for (y = [0:size_y-1]) {
        translate([x * size_x, y * size_y]) {
          cube([1, 1, 1]);
        }
      }
    }
  }
}

checkerboard(20, 30);