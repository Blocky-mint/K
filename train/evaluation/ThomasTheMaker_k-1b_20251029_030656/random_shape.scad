module random_shape(width, depth, height, radius, segments) {
  polygon(
    [
      for (i = [0:segments]) {
        for (j = [0:segments]) {
          translate([
            (i * width + j * width) / segments,
            (j * depth + i * depth) / segments,
            0
          ])
          circle(r = radius * cos(random(360)));
        }
      }
    ]
  );
}

random_shape(width = 50, depth = 50, height = 50, radius = 10, segments = 24);