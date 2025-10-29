// Trefoil Knot - Simplified version

// Parameters
radius = 10;
width = 15;
height = 10;
segments = 36;

module trefoil_knot() {
  difference() {
    union() {
      // Base
      cylinder(h = height, r = radius, $fn = segments);

      // Knot
      translate([0, 0, height])
        rotate([0, 0, 15])
          linear_extrude(height = width)
            polygon(points = [
              [0, 0],
              [0.5, 0],
              [0.5, height],
              [1, height]
            ]);
    }
    
    // Remove material to create the knot shape
    translate([0,0,height/2])
      cube([width,width,height]);
  }

  rotate([0,0,15])
  translate([0, 0, height/2])
      linear_extrude(height = width)
        polygon(points = [
          [0, 0],
          [0.5, 0],
          [0.5, height],
          [1, height]
        ]);
}

trefoil_knot();