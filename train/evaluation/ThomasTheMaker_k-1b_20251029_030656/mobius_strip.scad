// Parameters
thickness = 1;
width = 20;
height = 20;
num_segments = 48;

module mobius_strip(width, height, thickness) {
  linear_extrude(height = height, convexity = 10)
  polygon(points = [
      [0, 0],
      [width / 2, height / 2],
      [width / 2, -height / 2],
      [0, -height / 2]
  ]);
}

mobius_strip(width, height, thickness);