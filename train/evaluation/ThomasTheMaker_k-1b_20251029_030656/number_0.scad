// Number 0 in OpenSCAD
module number_zero(radius, height, segments) {
  linear_extrude(height = height, convexity = 10) {
    circle(r = radius);
  }
}

number_zero(radius = 10, height = 2, segments = 48);