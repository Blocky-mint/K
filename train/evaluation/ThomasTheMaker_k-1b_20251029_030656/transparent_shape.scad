module transparent_cube(size, thickness) {
  difference() {
    cube([size, size, thickness]);
    translate([size/4, size/4, thickness/4])
      cube([size/2, size/2, thickness]);
  }
}

transparent_cube([10, 10, 1]);