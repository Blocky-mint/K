module shell(width, height, depth, wall_thickness, fillet_radius) {
  difference() {
    cube([width, height, depth]);
    translate([wall_thickness, wall_thickness, wall_thickness])
    cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);

    for (i = [0:1]) {
        for (j = [0:1]) {
            translate([i * width, j * height, 0]) {
                cylinder(h = depth, r = fillet_radius, $fn = 32);
            }
        }
    }
  }
}

shell(width = 50, height = 30, depth = 20, wall_thickness = 2, fillet_radius = 1);