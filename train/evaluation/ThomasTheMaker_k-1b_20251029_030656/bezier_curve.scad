module bezier_curve(radius, h, num_points) {
  linear_extrude(height = h)
  for (i = [0:num_points-1]) {
    angle = i * 360 / num_points;
    x = radius * cos(angle);
    y = radius * sin(angle);
    translate([x, y, 0]) {
      circle(r = 1);
    }
  }
}

bezier_curve(radius = 2, h = 1, num_points = 20);