module cylinder(h, r_min, r_max) {
  cylinder(h, r_min, r_max);
}

stack_height = 50;
stack_width = 30;
stack_depth = 20;

difference() {
  for (i = [0:stack_height/stack_width:stack_height/stack_width]) {
    translate([i * stack_width, 0, 0]) {
      cylinder(stack_height, r_min, r_max);
    }
  }
}