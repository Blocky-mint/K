module heptagon(radius, height) {
  linear_extrude(height = height) {
    polygon(points=[
      [radius * cos(360 / 7), radius * sin(360 / 7)],
      [radius * cos(360 / 7), radius * sin(360 / 7)],
      [radius * cos(360 / 7) - radius * cos(360 / 7), radius * sin(360 / 7)],
      [radius * cos(360 / 7) - radius * cos(360 / 7), radius * sin(360 / 7)],
      [radius * cos(360 / 7) - radius * cos(360 / 7) - radius * cos(360 / 7), radius * sin(360 / 7)],
      [radius * cos(360 / 7) - radius * cos(360 / 7) - radius * cos(360 / 7) - radius * cos(360 / 7), radius * sin(360 / 7)],
      [radius * cos(360 / 7) - radius * cos(360 / 7) - radius * cos(360 / 7) - radius * cos(360 / 7) - radius * cos(360 / 7)]
    ]);
  }
}

heptagon(radius = 10, height = 20);