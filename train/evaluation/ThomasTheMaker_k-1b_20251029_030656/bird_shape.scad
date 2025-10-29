// Bird Shape in OpenSCAD

$fn = 32;

module bird(body_width, body_height, neck_height, wing_span, wing_length, beak_height) {
  difference() {
    union() {
      // Body
      cylinder(h = body_height, r1 = 5, r2 = 2, $fn = $fn);

      // Neck
      translate([0, 0, body_height])
        cylinder(h = neck_height, r1 = 2, r2 = 1, $fn = $fn);

      // Wings
      translate([0, body_height/2 + wing_length/2, 0])
        rotate([0, 0, -20])
          cube([body_width, wing_span, wing_length]);
      translate([0, body_height/2 - wing_length/2, 0])
        rotate([0, 0, 20])
          cube([body_width, wing_span, wing_length]);

      // Beak
      translate([0, body_height + neck_height + beak_height/2, 0])
        cube([body_width/2, 1, beak_height]);
    }

    // Subtract body for a hollow bird
    translate([0, 0, -0.1])
      cube([body_width, body_height, body_height + 10], center = true);
  }
}

bird(body_width = 20, body_height = 15, neck_height = 10, wing_span = 40, wing_length = 30, beak_height = 5);