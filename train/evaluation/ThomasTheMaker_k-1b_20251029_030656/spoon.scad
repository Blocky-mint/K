// Spoon parameters
spoon_length = 100;
spoon_width = 20;
spoon_depth = 5;
bowl_radius = 25;
handle_width = 10;
handle_thickness = 3;
handle_taper_start = 30;
handle_taper_end = 40;

module spoon() {
  difference() {
    union() {
      // Handle
      translate([0, 0, -handle_taper_start]) {
        cube([spoon_length, handle_width, handle_thickness]);
      }

      translate([0, handle_width, 0]) {
        cube([spoon_length, handle_width, handle_thickness]);
      }

      translate([spoon_length - handle_width, 0, 0]) {
        cube([handle_width, spoon_depth, handle_thickness]);
      }

      translate([spoon_length - handle_width, 0, 0]) {
        cube([spoon_length, spoon_depth, handle_thickness]);
      }
    }

    // Bowl
    translate([spoon_length - bowl_radius, 0, -0.1]) {
      rotate([0, 0, -30]) {
        cylinder(h = bowl_radius * 2, r = bowl_radius, $fn = 48);
      }
    }

    // Handle Taper
    translate([0, spoon_width, 0]) {
      linear_extrude(height = 0.1) {
        polygon(points = [
          [0, 0],
          [spoon_length - 0, handle_taper_start],
          [spoon_length - handle_taper_end, 0]
        ]);
      }
    }
  }
}

spoon();