// Fractal Branch

$fn = 50;

module fractal_branch(length, radius, segments) {
  linear_extrude(height = length, convexity = 10) {
    polygon(points = [
      for (i = [0:segments]) {
        for (j = [0:segments]) {
          translate([i * length, j * length, 0]) {
            circle(r = radius * cos(j * 360 / segments));
          }
        }
      }
    ]);
  }
}

fractal_branch(length = 50, radius = 2, segments = 32);