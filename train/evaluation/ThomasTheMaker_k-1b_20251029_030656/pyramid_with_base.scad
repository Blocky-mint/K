module pyramid(base_size, height) {
  linear_extrude(height = height)
  polygon(points = [[0,0], [base_size, 0], [base_size/2, base_size], [0, base_size]]);
}

pyramid(base_size = 20, height = 10);