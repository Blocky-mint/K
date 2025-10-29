// Screwdriver Model in OpenSCAD

// --- Parameters ---
handle_length = 80;
handle_diameter = 25;
handle_thickness = 10;
head_diameter = 35;
head_length = 20;
shank_diameter = 18;
shank_length = 120;
shaft_taper_angle = 10; // Degrees

module handle() {
  difference() {
    cylinder(h = handle_length, d = handle_diameter);
    translate([0, 0, handle_length - handle_thickness])
    cylinder(h = handle_thickness, d = handle_diameter - 5);
  }
}

module head() {
  difference() {
    cylinder(h = head_length, d = head_diameter);
    translate([0, 0, head_length - 5])
    cylinder(h = 5, d = 10);
  }
}

module shank() {
  cylinder(h = shank_length, d = shank_diameter);
}

// --- Assembly ---

// Main Body
translate([0, 0, 0]) {
  handle();
}

// Head
translate([0, 0, handle_length]) {
  head();
}

// Shaft (Simplified) -  Just a cylinder for demonstration
translate([0, 0, -shank_length]) {
  cylinder(h = shank_length, d = shank_diameter);
}

translate([0, 0, -shank_length + shank_length]) {
  translate([0, 0, -shank_length + shank_length])
  cylinder(h = shank_length - 10, d = shank_diameter);
}

translate([0, 0, -shank_length + shank_length + shank_length]) {
  translate([0, 0, -shank_length + shank_length]) {
    translate([0, 0, -shank_length + shank_length])
    cylinder(h = 5, d = shaft_taper_angle);
  }
}

translate([0, 0, -shank_length + shank_length + shank_length]) {
  translate([0, 0, -shank_length + shank_length]) {
    translate([0, 0, -shank_length + shank_length]) {
        cylinder(h = 5, d = shaft_taper_angle);
    }
  }
}

// Combine all parts
difference() {
  union() {
    translate([0, 0, 0]) {
        handle();
    }
    translate([0, 0, handle_length]) {
        head();
    }
    translate([0, 0, shank_length]) {
        translate([0, 0, -shank_length]) {
            translate([0, 0, -shank_length]) {
                translate([0, 0, -shank_length + shank_length]) {
                    cylinder(h = shank_length, d = shank_diameter);
                }
            }
        }
    }
    translate([0, 0, shank_length + shank_length]) {
        translate([0, 0, -shank_length + shank_length]) {
            translate([0, 0, -shank_length + shank_length]) {
                translate([0, 0, -shank_length + shank_length]) {
                    cylinder(h = 5, d = shaft_taper_angle);
                }
            }
        }
    }
  }
  
  translate([0, 0, -shank_length]) {
    translate([0, 0, -shank_length]) {
        translate([0, 0, -shank_length + shank_length]) {
            cylinder(h = 5, d = shaft_taper_angle);
        }
    }
  }
  translate([0, 0, -shank_length + shank_length + shank_length]) {
    translate([0, 0, -shank_length + shank_length]) {
        translate([0, 0, -shank_length + shank_length]) {
            translate([0, 0, -shank_length + shank_length]) {
                cylinder(h = 5, d = shaft_taper_angle);
            }
        }
    }
  }
}