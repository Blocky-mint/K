module tee_beam(width, height, wall_thickness, flange_width, flange_height, fillet_radius) {
  difference() {
    cube([width, height, wall_thickness]);
    translate([0, 0, -0.1])
    cube([width, height, wall_thickness + 0.2]);
  }
}

module tee_beam_with_fillet(width, height, wall_thickness, flange_width, flange_height, fillet_radius) {
  difference() {
    cube([width, height, wall_thickness]);
    translate([0, 0, -0.1])
    cube([width, height, wall_thickness + 0.2]);
    
    for (i = [0:1]) {
      for (j = [0:1]) {
        translate([i * (width - flange_width), j * (height - flange_height), 0])
        rotate([90, 0, 0])
        cylinder(r = fillet_radius, h = height, $fn = 50);
      }
    }
  }
}

// Example Usage:
width = 60;
height = 80;
wall_thickness = 3;
flange_width = 40;
flange_height = 10;
fillet_radius = 2;

translate([0, 0, wall_thickness])
tee_beam_with_fillet(width, height, wall_thickness, flange_width, flange_height, fillet_radius);