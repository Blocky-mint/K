module nonagon(radius = 10, segments = 12) {
  linear_extrude(height = 1) {
    polygon(points = [
      for (i = [0:segments-1])
      rotate([0, 0, 360 * i / segments])
      polygon(points = [
        [radius * cos(i * 360 / segments), radius * sin(i * 360 / segments)],
        [radius * sin(i * 360 / segments), radius * cos(i * 360 / segments)]
      ]);
    ]);
  }
}

nonagon();