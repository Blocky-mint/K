module lattice(size, height, width, depth, num_spokes, spacing) {
  linear_extrude(height = height) {
    polygon(points = [
      [0, 0],
      [width/2, -depth],
      [width/2, depth],
      [0, depth]
    ]);
  }
}

lattice(size = 50, height = 10, width = 50, depth = 20, num_spokes = 10, spacing = 5);