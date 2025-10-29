// Pivot Mount Parameters
pivot_hole_diameter = 6;
pivot_hole_offset_x = 20;
pivot_hole_offset_y = 20;
base_width = 50;
base_height = 30;
base_depth = 20;
arm_width = 15;
arm_height = 25;
arm_depth = 10;
hole_diameter = 3;

module pivot_hole(diameter, offset_x, offset_y) {
  cylinder(h=1, r=diameter/2, center=true, $fn=60);
}

difference() {
  union() {
    // Base
    cube([base_width, base_height, base_depth]);

    // Pivot Hole
    translate([pivot_hole_offset_x, pivot_hole_offset_y, 0]) {
      pivot_hole(pivot_hole_diameter, 0, 0);
    }

    // Arm
    translate([base_width/2 - arm_width/2, base_height/2 - arm_height/2, 0]) {
      cube([arm_width, arm_height, arm_depth]);
    }
  }

  // Clearance for mounting (simplified)
  translate([base_width/2, base_height/2, 0]) {
      cube([base_width - base_width/4, base_height - base_height/4, base_depth - base_depth/4]);
  }
}