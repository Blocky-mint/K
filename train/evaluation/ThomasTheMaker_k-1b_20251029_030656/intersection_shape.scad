module intersection(width, height, depth, angle) {
  hull() {
    translate([0, 0, 0]) cube([width, height, depth]);
    translate([width/2, height/2, 0]) rotate([angle, 0, 0]) cube([width/2, height/2, depth]);
    translate([-width/2, height/2, 0]) rotate([-angle, 0, 0]) cube([width/2, height/2, depth]);
  }
}

intersection(width = 10, height = 10, depth = 10, angle = 30);