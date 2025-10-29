module wavy_surface(length, width, height, frequency, resolution) {
  difference() {
    cube([length, width, height], center = true);
    for (i = [0:resolution]) {
      for (j = [0:resolution]) {
        translate([i * (length + width) / (resolution + 1), j * (height + width) / (resolution + 1), 0]) {
          rotate([0, 0, i * frequency]) {
            linear_extrude(height = 1)
              polygon(points = [
                [0, 0],
                [1, 0],
                [1, 1],
                [0, 1]
              ]);
          }
        }
      }
    }
  }
}

wavy_surface(length = 100, width = 50, height = 10, frequency = 2, resolution = 30);