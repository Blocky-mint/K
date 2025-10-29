module crescent(radius, thickness, angle) {
  difference() {
    rotate([0,0,angle])
    translate([0,0,0])
    linear()
    polygon(points = [
      [0, 0],
      [radius, 0],
      [radius, thickness],
      [0, thickness]
    ]);
    
    linear()
    translate([radius - thickness/2, 0, 0])
    rotate([0,0,-angle])
    polygon(points = [
      [0, 0],
      [radius, 0],
      [radius, thickness],
      [0, thickness]
    ]);
  }
}

crescent(radius = 20, thickness = 3, angle = 30);