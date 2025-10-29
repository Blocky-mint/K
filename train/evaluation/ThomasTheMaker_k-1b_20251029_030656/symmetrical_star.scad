module star(radius, height, segments) {
  linear_extrude(height = height)
  polygon(points = [
    [radius * cos(360 / segments) * (1 - 2 * sin(360 / segments)),
     radius * sin(360 / segments) * (1 - 2 * sin(360 / segments))],
    [radius * cos(360 / segments) * (1 - 2 * sin(360 / segments)),
     radius * sin(360 / segments) * (1 - 2 * sin(360 / segments))],
    [radius * cos(360 / segments) * (1 - 2 * sin(360 / segments)),
     radius * sin(360 / segments) * (1 - 2 * sin(360 / segments))],
    [radius * cos(360 / segments) * (1 - 2 * sin(360 / segments)),
     radius * sin(360 / segments) * (1 - 2 * sin(360 / segments))],
    [radius * cos(360 / segments) * (1 - 2 * sin(360 / segments)),
     radius * sin(360 / segments) * (1 - 2 * sin(360 / segments))],
    [radius * cos(360 / segments) * (1 - 2 * sin(360 / segments)),
     radius * sin(360 / segments) * (1 - 2 * sin(360 / segments))]
  ]);
}

// Adjust parameters as needed
radius = 20;
height = 10;
segments = 6;

star(radius, height, segments);