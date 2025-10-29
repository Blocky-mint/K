module tube(r, h, segments) {
  linear_extrude(height = h, convexity = 10, slices = segments)
    circle(r = r);
}

tube(r = 5, h = 20, segments = 64);