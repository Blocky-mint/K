// Leaf Parameters
leaf_width = 50;
leaf_height = 40;
leaf_detail = 32;
vein_width = 3;
vein_offset = 15;

module leaf() {
  difference() {
    hull() {
      translate([0,0,0]) sphere(r=1);
      translate([leaf_width/4,0,0]) sphere(r=1);
      translate([-leaf_width/4,0,0]) sphere(r=1);
    }

    // Veins
    translate([0, -vein_offset, 0])
    cube([vein_width, leaf_height, 1]);
    translate([leaf_width/2, -vein_offset, 0])
    cube([vein_width, leaf_height, 1]);
  }
}

leaf();