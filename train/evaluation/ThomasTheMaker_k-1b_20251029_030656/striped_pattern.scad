module stripe(width, height, color1, color2, angle) {
  linear_extrude(height = height) {
    polygon(points = [
      [0,0],
      [width/2, 0],
      [width/2, height * tan(angle)],
      [0, height * tan(angle)]
    ]);
  }
}

// Example usage:
stripe(width = 50, height = 30, color1 = [1, 0, 0], color2 = [0, 0, 1], angle = 45);