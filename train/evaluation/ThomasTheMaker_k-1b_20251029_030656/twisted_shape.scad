// Parameters for the twisted shape
r_base = 20;
r_top = 20;
height = 50;
angle = 30;

module twisted_shape(base_radius, top_radius, height, angle) {
  difference() {
    union() {
      // Base
      cylinder(r = base_radius, h = height, $fn = 50);

      // Top
      rotate([0, 0, angle])
        translate([0, 0, height])
          cylinder(r = top_radius, h = height, $fn = 50);
    }

    // Remove material at the top for twisting (optional)
    translate([0, 0, height - 5]) {
      rotate([0, 0, angle])
        cylinder(r = base_radius * 0.7, h = height + 10, $fn = 50);
    }
  }
}

twisted_shape(r_base, r_top, height, angle);