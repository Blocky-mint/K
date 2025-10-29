module figure_eight(width = 5, height = 5, depth = 2) {
  hull() {
    translate([0, 0, 0]) cube([width, height, depth]);
    translate([width, height, depth]) cube([width, height, depth]);
    translate([0, height, depth]) cube([width, height, depth]);
    translate([0, 0, height]) cube([width, height, depth]);
    translate([width, 0, height]) cube([width, height, depth]);
    translate([width, height, 0]) cube([width, height, depth]);
  }
}

figure_eight();