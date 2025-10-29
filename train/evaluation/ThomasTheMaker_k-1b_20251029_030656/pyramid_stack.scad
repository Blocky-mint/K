module pyramid(height, base_width, base_depth, base_height) {
  polyhedron(
    points = [[0, 0, 0], [base_width, 0, 0], [base_width, base_depth, 0], [0, base_depth, 0], [0, 0, height]],
    faces = [[0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4], [0, 1, 2, 3]]
  );
}

pyramid(height = 10, base_width = 20, base_depth = 20, base_height = 5);