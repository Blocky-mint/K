module hexagon(radius) {
  polygon(points = [
    [radius, 0],
    [radius * cos(60), radius * sin(60)],
    [radius * cos(120), radius * sin(120)],
    [radius * cos(180), radius * sin(180)],
    [radius * cos(240), radius * sin(240)],
    [radius * cos(300), radius * sin(300)]
  ]);
}

hexagon(radius = 10);