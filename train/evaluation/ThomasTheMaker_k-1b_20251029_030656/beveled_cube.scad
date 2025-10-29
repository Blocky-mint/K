module beveled_cube(size, angle, height) {
  difference() {
    cube([size, size, height]);
    
    for (i = [0:size]) {
      for (j = [0:size]) {
        translate([i * size, j * size, 0]) {
          rotate([0, 0, angle * 360 / size]) {
            translate([0, 0, -height/2]) {
              cube([1,1,height/2]);
            }
          }
        }
      }
    }
  }
}

bevelled_cube(size = 50, angle = 45, height = 10);