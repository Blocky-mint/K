module channel(width, depth, height, wall_thickness) {
    difference() {
        cube([width, depth, height]);
        translate([wall_thickness, wall_thickness, 0])
        cube([width - 2 * wall_thickness, depth - 2 * wall_thickness, height]);
    }
}

channel(width = 50, depth = 30, height = 10, wall_thickness = 2);