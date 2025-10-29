// Parameters
point_radius = 2;
point_height = 2;
point_offset = 2;

module star(points) {
  for (i = [0:5]) {
    angle = i * 360 / 5;
    
    translate([
      point_offset * cos(angle),
      point_offset * sin(angle),
      0
    ]) {
      linear_extrude(height = point_height) {
        polygon(points = [
          [0, 0],
          [point_radius * 1.5, point_radius * 0.5],
          [point_radius * 1.5, point_radius * 0.8],
          [0, point_radius * 0.8],
          [0, 0]
        ]);
      }
    }
  }
}

star(points = [
  [0, 0],
  [1.2, 1.5],
  [2.5, 2],
  [3, 3.2],
  [4, 1.8],
  [5, 0.8]
]);