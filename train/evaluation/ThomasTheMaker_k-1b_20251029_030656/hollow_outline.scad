module hollow_outline(width, height, depth, wall_thickness, detail = 6) {
  difference() {
    hull() {
      translate([0, 0, 0]) cube([width, height, depth]);
      translate([width/4, height/4, depth/4]) cube([width/2, height/2, depth/2]);
      translate([width/4, 0, depth/4]) cube([width/2, height, depth/2]);
      translate([0, height/4, depth/4]) cube([width, height/2, depth/2]);
      translate([0, 0, 0]) cube([width, height, depth]);
    }
    translate([wall_thickness, wall_thickness, wall_thickness]) {
      difference() {
        cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);
        translate([0, 0, 0]) cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);
        translate([0, 0, 0]) cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);
        translate([0, 0, 0]) cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);
        translate([0, 0, 0]) cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);
        translate([0, 0, 0]) cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);
        translate([0, 0, 0]) cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);

      }
    }
  }
}

hollow_outline(width = 50, height = 70, depth = 20, wall_thickness = 3, detail = 16);