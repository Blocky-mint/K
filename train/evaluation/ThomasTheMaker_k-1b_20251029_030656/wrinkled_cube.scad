// Wrinkled Cube

module wrinkled_cube(size, wrinkles = 10) {
  difference() {
    cube([size, size, size]);
    
    for (i = [0:wrinkles-1]) {
      translate([i * (size + size/wrinkles), i * (size + size/wrinkles), i * (size + size/wrinkles)]) {
        linear_extrude(height = size) {
          polygon([
            [0, 0],
            [size/wrinkles, size/wrinkles],
            [size/wrinkles, -size/wrinkles]
          ]);
        }
      }
    }
  }
}

wrinkled_cube(size = 50, wrinkles = 15);