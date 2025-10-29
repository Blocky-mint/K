module helix(radius, height, turns, segments) {
  linear_extrude(height = height) {
    rotate_extrude(angle = 360 / turns) {
      circle(r = radius);
    }
  }
}

helix(radius = 50, height = 100, turns = 5, segments = 100);