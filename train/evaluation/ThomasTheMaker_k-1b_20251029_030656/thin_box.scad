module box(width, height, depth, thickness) {
  cube([width, height, depth]);
}

thickness = 1;
box(10, 5, 2, thickness);