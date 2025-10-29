module gradient(size, gradient_start, gradient_end, offset = 0) {
  linear_extrude(height = offset) {
    polygon(points = [
      [size[0], size[1]],
      [size[0] + offset, size[1] + offset],
      [size[0] + offset, size[1] + offset * 0.5],
      [size[0], size[1] + offset * 0.5]
    ]);
  }
}

// Example usage:
gradient(size = 50, gradient_start = 20, gradient_end = 50, offset = 0);