module octagon(radius, height) {
  linear_extrude(height = height) {
    polygon(points = [
      [radius, 0],
      [radius * cos(45), radius * sin(45)],
      [radius * cos(90), radius * sin(90)],
      [radius * cos(135), radius * sin(135)],
      [radius * cos(180), radius * sin(180)],
      [radius * cos(225), radius * sin(225)],
      [radius * cos(270), radius * sin(270)],
      [radius * cos(315), radius * sin(315)]
    ]);
  }
}

octagon(radius = 10, height = 5);