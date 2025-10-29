// Pliers Design in OpenSCAD

// Parameters
handle_length = 100;
handle_diameter = 20;
jaw_length = 50;
jaw_diameter = 30;
pivot_diameter = 15;
pivot_length = 25;
pivot_hole_diameter = 4;
finger_length = 40;
finger_width = 10;
finger_height = 10;

// Handle
module handle() {
  cylinder(h = handle_length, d = handle_diameter);
}

// Jaw
module jaw() {
  cylinder(h = jaw_length, d = jaw_diameter);
}

// Pivot
module pivot() {
  cylinder(h = pivot_length, d = pivot_diameter);
}

// Finger
module finger() {
  cube([finger_width, finger_height, finger_length]);
}

// Assembly
difference() {
  union() {
    translate([0, 0, 0]) {
      handle();
      translate([0, handle_diameter/2 + 2, handle_length - jaw_length]) {
        jaw();
      }
    }
    translate([0, handle_diameter/2 + 2, handle_length - jaw_length]) {
      pivot();
      translate([0, handle_diameter/2 + 2, pivot_length]) {
        translate([0, 0, 0]) {
          rotate([90, 0, 0]) {
            translate([jaw_diameter/2, 0, 0]) {
              rotate([90, 0, 0]) {
                translate([0, 0, 0]) {
                  translate([0, 0, 0]) {
                    finger();
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  translate([0, handle_diameter/2 + 2, handle_length - jaw_length]) {
    difference() {
        cube([handle_diameter*2, handle_diameter*2, handle_length]);
        translate([0, 0, 0]) {
            cube([handle_diameter*2, handle_diameter*2, handle_length]);
        }
    }
  }
}