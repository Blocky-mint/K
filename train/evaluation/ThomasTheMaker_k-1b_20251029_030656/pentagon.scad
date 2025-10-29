module pentagon(radius, height) {
  linear_extrude(height = height)
    polygon(points = [
      [radius * cos(360), radius * sin(360)],
      [radius * cos(540), radius * sin(540)],
      [radius * cos(720), radius * sin(720)],
      [radius * cos(900), radius * sin(900)],
      [radius * cos(1140), radius * sin(1140)]
    ]);
}

pentagon(radius = 10, height = 5);