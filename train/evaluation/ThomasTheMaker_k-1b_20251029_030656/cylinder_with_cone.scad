difference() {
  cylinder(h=10, r1=5, r2=0);
  rotate_extrude(convexity=10) {
    translate([0,0,0])
    linear_extrude(height = 10)
    polygon(points=[[0,0], [r1, 0], [r1, 1], [0, 1]]);
  }
}