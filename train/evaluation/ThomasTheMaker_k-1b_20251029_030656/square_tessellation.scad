// Tessellation parameters
size = 100;
count = 5;

module square_tessellation(size, count) {
  for (i = [0:count-1]) {
    translate([size * i / count, 0, 0]) {
      square(size);
    }
  }
}

module square(size) {
  difference() {
    cube([size, size, size]);
    translate([size/4, size/4, size/4]) cube([size/2, size/2, size/2]);
  }
}

square_tessellation(size, count);