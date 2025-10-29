module hexagonal_prism(width, height, depth, angle) {
  linear_extrude(height = depth) {
    polygon(points = [
      [width / 2, 0],
      [width / 2, height],
      [0, height],
      [-width / 2, height],
      [-width / 2, 0],
      [0, 0]
    ]);
  }
}

// Example usage:
width = 50;
height = 25;
depth = 10;
angle = 360;

difference() {
  linear_extrude(height = depth) {
    polygon(points = [
      [width / 2, 0],
      [width / 2, height],
      [0, height],
      [-width / 2, height],
      [-width / 2, 0],
      [0, 0]
    ]);
  }
  
  translate([0, 0, -0.1]) {
    linear_extrude(height = depth) {
      polygon(points = [
        [width / 2, 0],
        [width / 2, height],
        [0, height],
        [-width / 2, height],
        [-width / 2, 0],
        [0, 0]
      ]);
    }
  }
}