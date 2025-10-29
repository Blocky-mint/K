module angle_iron(height, width, depth, angle) {
  linear_extrude(height = height)
  polygon(points = [
    [0, 0],
    [width/2, -depth * tan(angle)],
    [width, 0]
  ]);
}

angle_iron(height = 10, width = 5, depth = 2, angle = 45);