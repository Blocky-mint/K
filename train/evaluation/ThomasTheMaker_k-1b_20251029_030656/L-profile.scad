module l(width, height, depth, angle = 15, segments = 48) {
  linear_extrude(height = depth, convexity = 10)
  polygon(points = [
    [0, 0],
    [width / 2, height * tan(angle)],
    [width, height * tan(angle) * 2],
    [0, 0]
  ]);
}

l(width = 5, height = 5, depth = 5);