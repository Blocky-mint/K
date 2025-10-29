// Container dimensions
container_width = 100;
container_depth = 50;
container_height = 30;
lid_width = 100;
lid_depth = 50;
lid_height = 30;

module container() {
    cube([container_width, container_depth, container_height]);
}

module lid() {
    cube([lid_width, lid_depth, lid_height]);
}

difference() {
    container();
    translate([container_width/2 - lid_width/2, container_depth/2 - lid_depth/2, 0]) {
        lid();
    }
}