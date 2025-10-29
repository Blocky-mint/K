$fn = 32;

module glass(length, width, height, thickness, transparency) {
  difference() {
    cube([length, width, height]);
    translate([length/2 - 1, width/2 - 1, 0])
    cube([2, 2, height + 1]);
  }

  translate([0, 0, -0.1]) {
      glass(length = 50, width = 30, height = 20, thickness = 2, transparency = 0.5);
  }