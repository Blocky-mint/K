// Dice in OpenSCAD

module dice(size, segments) {
  difference() {
    cube([size, size, size]);
    for (i = [0:segments-1]) {
      for (j = [0:segments-1]) {
        translate([i * (size / segments), j * (size / segments), 0])
          cube([size/segments, size/segments, size/segments]);
      }
    }
  }
}

dice(30, 12);