module ring(radius, height, segments = 36) {
  cylinder(r = radius, h = height, $fn = segments);
}

ring(radius = 10, height = 20);