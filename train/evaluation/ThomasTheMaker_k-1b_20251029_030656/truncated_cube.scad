module truncated_cube(size, height, angle) {
  linear_extrude(height = height) {
    polygon(points=[[size[0], 0], [size[1], height], [size[1], 0]]);
  }
}

truncated_cube(size = 20, height = 10, angle = 20);