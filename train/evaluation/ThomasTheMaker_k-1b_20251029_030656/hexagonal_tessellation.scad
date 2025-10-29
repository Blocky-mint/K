$fn=50;

module hexagonal_tessellation(width, height) {
  for (i = [0:width/1]) {
    for (j = [0:height/1]) {
      translate([i * (width/width), j * (height/height), 0]) {
        difference() {
          union() {
            for (angle = [0:360]); {
              translate([cos(angle), sin(angle), 0]) {
                translate([0, 0, 0]) {
                  linear_extrude(height = height) {
                    polygon(points = [
                      [width/width, 0],
                      [width/width, height],
                      [0, height],
                      [0, 0],
                      [-width/width, height],
                      [0, 0]
                    ]);
                  }
                }
              }
            }
          }
          translate([0, 0, -0.1])
          cube([width, height, 0.2]);
        }
      }
    }
  }
}

linear_extrude(height = 1) {
  difference() {
    cube([100,100,1]);
    translate([20,20,0])
    cube([80,80,1]);
  }
}

linear_extrude(height = 1) {
  difference() {
    cube([100,100,1]);
    translate([20,20,0])
    cube([80,80,1]);
  }
}