module radial_symmetry(radius, height, segments, twist_angle) {
  linear_extrude(height = height) {
    polygon(points = [
      [radius * cos(twist_angle), radius * sin(twist_angle)],
      [radius * cos(360 - twist_angle), radius * sin(360 - twist_angle)]
    ]);
  }
}

linear_extrude(height = 1) {
  radial_symmetry(radius = 10, height = 5, segments = 20, twist_angle = 30);
}