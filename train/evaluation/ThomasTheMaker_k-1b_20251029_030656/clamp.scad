// Adjustable Clamp

// Parameters
clamp_width = 50;
clamp_height = 30;
clamp_depth = 20;
screw_diameter = 3;
screw_length = 25;
screw_hole_diameter = screw_diameter + 1;
adjustment_range = 10;

// Main Body
module clamp_body(width, height, depth) {
  difference() {
    cube([width, height, depth]);
    translate([clamp_width/2 - 10, 0, 0])
    cube([10, height, depth]);
  }
}

// Screw Hole
module screw_hole(diameter, depth) {
  cylinder(h = depth, r = diameter/2, $fn = 100);
}

// Adjustment
module adjustment(value) {
  translate([0, 0, -clamp_height/2 + adjustment_range * value]) {
    cube([clamp_width, clamp_height, clamp_depth]);
  }
}

// Assembly
difference() {
  clamp_body(clamp_width, clamp_height, clamp_depth);

  // Screw Holes
  translate([clamp_width/2 - screw_diameter/2, clamp_height/2 - screw_diameter/2, clamp_depth/2 - screw_diameter/2]) screw_hole(screw_hole(screw_diameter, clamp_depth));
  translate([clamp_width/2 - screw_diameter/2, -clamp_height/2 - screw_diameter/2, clamp_depth/2 - screw_diameter/2]) screw_hole(screw_hole(screw_diameter, clamp_depth));

  // Adjustment
  for (i = [0:adjustment_range:clamp_height*clamp_width*clamp_height/30 - adjustment_range*15]) {
    adjust()
    rotate([0,0,i])
    translate([0,0,clamp_height])
    cube([clamp_width, clamp_height, clamp_depth]);
  }
}