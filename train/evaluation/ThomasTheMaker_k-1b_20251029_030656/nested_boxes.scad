module nested_boxes(width, height, depth, box_width, box_height, box_depth) {
  for (i = [0:3]) {
    for (j = [0:3]) {
      translate([box_width + (i * width), box_width + (j * height), box_depth + (i * depth)]) {
        cube([width, height, depth]);
      }
    }
  }
}

nested_boxes(10, 10, 5, 2, 2, 2);