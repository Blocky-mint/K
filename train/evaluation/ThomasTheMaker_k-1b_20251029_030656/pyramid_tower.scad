module pyramid_tower(height, width, depth, radius) {
  difference() {
    union() {
      translate([0, 0, 0]) {
        cylinder(h = height, r = radius, $fn = 32);
      }
      translate([0, 0, height]) {
        cylinder(h = width, r = radius, $fn = 32);
      }
      translate([0, 0, -height]) {
        cylinder(h = depth, r = radius, $fn = 32);
      }
    }
    translate([0, 0, 0]) {
      cylinder(h = height, r = radius * 0.7, $fn = 32);
    }
    translate([0, 0, height]) {
      cylinder(h = width, r = radius * 0.7, $fn = 32);
    }
    translate([0, 0, -height]) {
      cylinder(h = depth, r = radius * 0.7, $fn = 32);
    }
  }

  translate([0,0,0]) {
    rotate([90,0,0]) {
      translate([0,0,0]) {
        translate([0,0,0]) {
          difference() {
            cube([width, depth, height]);
            translate([0,0,0]) {
              cube([width, depth, height]);
            }
          }
        }
      }
    }
  }
}

pyramid_tower(height = 50, width = 20, depth = 10, radius = 10);