module blob(radius, height, segments) {
  sphere(r = radius, $fn = segments);
}

blob(radius = 10, height = 5, segments = 50);