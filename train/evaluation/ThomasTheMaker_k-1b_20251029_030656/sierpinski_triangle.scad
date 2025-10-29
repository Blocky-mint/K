module sierpinski_triangle(size, height) {
  linear_extrude(height = height) {
    polygon(points = [
      [size[0] * cos(30), size[1] * sin(30)],
      [size[1] * cos(30), size[2] * sin(30)],
      [size[0] * sin(30), size[2] * cos(30)]
    ]);
  }
}

sierpinski_triangle(size = 20, height = 30);