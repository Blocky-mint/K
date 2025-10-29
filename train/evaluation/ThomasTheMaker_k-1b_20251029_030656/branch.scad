module branch(length, radius, segments=32) {
  cylinder(h = length, r = radius, $fn = segments);
}

branch(length = 100, radius = 10, segments = 32);