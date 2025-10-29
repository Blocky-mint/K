module triangular_prism(width, height, depth) {
  linear_extrude(height = depth) {
    polygon(points=[[0,0], [width/2, height], [width,0]]);
  }
}

// Example usage:
width = 20;
height = 10;
depth = 5;

triangular_prism(width, height, depth);