module frustum(height, width, depth, radius, segments=6) {
  difference() {
    hull() {
      translate([0,0,0]) sphere(r=radius, $fn=segments);
      translate([1,0,0]) sphere(r=radius, $fn=segments);
      translate([0.5,0,0]) sphere(r=radius, $fn=segments);
      translate([0,1,0]) sphere(r=radius, $fn=segments);
    }
    linear_extrude(height = height, convexity = 10)
    polygon(points=[[0,0], [width, depth], [0, depth]]);
  }
}

// Parameters
radius = 20;
width = 30;
depth = 20;
height = 40;

// Call the module
frustum(height, width, depth, radius);