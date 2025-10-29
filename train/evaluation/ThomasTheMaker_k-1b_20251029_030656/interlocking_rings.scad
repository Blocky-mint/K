// Interlocking Rings

// Parameters
ring_thickness = 1;
hole_diameter = 2;
width = 20;
height = 40;
num_rings = 10;

module ring(width, height, thickness) {
  difference() {
    cube([width, height, thickness]);
    translate([width/2 - hole_diameter/2, height/2 - hole_diameter/2, 0])
    cylinder(h = thickness, r = hole_diameter/2);
  }
}

module interlocking_assembly(rings_width, rings_height, rings_thickness) {
  for (i = [0:num_rings - 1]) {
    translate([i * rings_width, 0, 0]) {
      ring(rings_width, rings_height, rings_thickness);
    }
  }
}

// Render the interlocking rings
//linear_extrude(height = height, convexity = 10) {
//    ring(width = width, height = width, thickness = ring_thickness);
//
//    translate([width/2,0,height/2])
//    cylinder(h = width, r = width/2);
//
//    translate([0, height/2, width/2])
//    cylinder(h = width, r = width/2);
//
//    translate([0,0,height/2])
//    cylinder(h = width, r = width/2);
//
//    translate([0,0,width/2])
//    cylinder(h = width, r = width/2);
//
//    translate([0,0,0])
//    cube([width, height, width]);
//}