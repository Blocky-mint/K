// 8-pointed star in OpenSCAD

module star(points = [
  [0, 0, 2],
  [1, 0, 1],
  [2, 1, 0],
  [3, 0, 0],
  [4, 1, 1],
  [5, 0, 0],
  [6, 0, 0],
  [7, 1, 1],
  [8, 0, 0]
]) {
  
  // Define the inner triangle
  difference() {
    polygon([
      [0, 0],
      [1, 0],
      [2, 1]
    ]);
    translate([0,0,2]) cube([1,1,1]);
  }

  // Main star shape
  for (i = [0:7]) {
    rotate([i * 180 / 8, 0, 0]) {
      translate([
        points[i][0],
        points[i][1],
        points[i][2]
      ])
      linear_extrude(height = 1)
      polygon(points = [
        points[i][0],
        points[i][1],
        points[i][2]
      ]);
    }
  }
}

star(points = [
  [0, 0, 2],
  [1, 0, 1],
  [2, 1, 0],
  [3, 0, 0],
  [4, 1, 1],
  [5, 0, 0],
  [6, 0, 0],
  [7, 1, 1],
  [8, 0, 0]
]);