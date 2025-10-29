width = 100;
depth = 50;
height = 20;

difference() {
  cube([width, depth, height]);
  translate([10, 10, 10]) cube([width - 20, depth - 20, height - 20]);
}