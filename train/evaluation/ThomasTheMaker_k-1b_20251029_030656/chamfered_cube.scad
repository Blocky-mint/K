module chamfered_cube(size, chamfer_radius) {
  difference() {
    cube([size, size, size]);
    translate([chamfer_radius, chamfer_radius, chamfer_radius])
      cube([size - 2 * chamfer_radius, size - 2 * chamfer_radius, size - 2 * chamfer_radius]);
  }
}

chamfered_cube([20, 20, 20], 2);