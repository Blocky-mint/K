module twisted_cylinder(height, inner_radius, outer_radius, twist_angle, segments) {
  linear_extrude(height = height, convexity = 10) {
    polygon(points = [
      [0, 0],
      [height, 0],
      [height * cos(twist_angle), height * sin(twist_angle)],
      [0, height]
    ]);
  }
}

twisted_cylinder(height = 20, inner_radius = 10, outer_radius = 15, twist_angle = 30, segments = 64);