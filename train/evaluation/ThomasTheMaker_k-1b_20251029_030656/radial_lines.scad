module radial_lines(radius, height, num_lines, line_width) {
  if (num_lines <= 0) {
    return [];
  }

  linear_height = height / num_lines;

  for (i = [0:num_lines-1]) {
    angle = i * 360 / num_lines;
    x = radius * cos(angle);
    y = radius * sin(angle);
    
    translate([x, y, 0]) {
      linear_height = height / num_lines;
      linear_height = linear_height * (1 - (i / num_lines));
    }
  }
}

linear_lines(radius = 10, height = 20, num_lines = 10, line_width = 2);