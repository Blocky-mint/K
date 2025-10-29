module cavity(width, depth, height, cavity_width, cavity_depth, cavity_height) {
    difference() {
        cube([width, depth, height]);
        translate([width/4, depth/4, 0])
        cube([width/2, depth/2, cavity_height]);
    }
}

// Example usage:
width = 50;
depth = 30;
height = 20;
cavity_width = 20;
cavity_depth = 15;
cavity_height = 10;

difference() {
    cube([width, depth, height]);
    translate([width/4, depth/4, 0])
    cube([width/2, depth/2, cavity_height]);
}