module i_beam(length, width, height, fillet_radius) {
  difference() {
    cube([length, width, height]);
    translate([length - 1, 0, 0])
    cube([1, width, height]);
    translate([0, width - 1, 0])
    cube([length, 1, height]);
  }
}

i_beam(length = 100, width = 20, height = 10, fillet_radius = 2);