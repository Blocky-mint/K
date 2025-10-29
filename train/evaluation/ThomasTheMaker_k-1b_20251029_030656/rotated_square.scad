module rotated_square(size) {
  difference() {
    cube([size, size, size]);
    for (i = [0, 1, 2]) {
      for (j = [0, 1, 2]) {
        translate([i * (size / 3), j * (size / 3), 0]) {
          rotate([0, 0, 45]) {
            translate([0, 0, -size / 4]) {
              cube([size, size, size]);
            }
          }
        }
      }
    }
  }
}

rotated_square([50, 50, 50]);