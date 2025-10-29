// Box dimensions
box_width = 100;
box_depth = 50;
box_height = 25;

difference() {
  cube([box_width, box_depth, box_height]);
  translate([1,1,1])
  cube([box_width-2, box_depth-2, box_height-2]);
}