$fn = 50;
radius = 10;
height = 20;
turns = 20;
segments = 64;

module helix(radius, height, turns, segments) {
  for (i = [0:turns-1]) {
    rotate([0,0,i * 360 / turns]) {
      translate([radius, 0, height * i / turns]) {
        cube([1, 1, 1], center = true);
      }
    }
  }
}

helix(radius, height, turns, segments);