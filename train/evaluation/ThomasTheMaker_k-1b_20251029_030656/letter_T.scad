module t(height = 10, width = 50, depth = 20, rounding = 2) {
  hull() {
    translate([0, 0, 0])
    sphere(r = depth/2);
    translate([width/2, 0, height])
    sphere(r = depth/2);
    translate([-width/2, 0, height])
    sphere(r = depth/2);
  }
  
  linear_extrude(height = height, convexity = 10)
  polygon(points = [
    [0,0],
    [width/2, depth/2],
    [width/2, -depth/2]
  ]);
  
  difference() {
      linear_extrude(height = height, convexity = 10)
      polygon(points = [
        [0,0],
        [width/2, depth/2],
        [width/2, -depth/2]
      ]);
  }
}

t(height = 20, width = 60, depth = 30, rounding = 2);