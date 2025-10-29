module pyramid(base_width, base_depth, height) {
  polyhedron(points=[[0, 0, 0], [base_width, 0, 0], [base_width, base_depth, 0], [0, base_depth, 0]]);
}

pyramid(20, 20, 20);