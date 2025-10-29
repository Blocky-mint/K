// Nut parameters
outer_diameter = 20;
inner_diameter = 16;
height = 5;
thread_depth = 2;
thread_pitch = 1.75;

difference() {
  cylinder(h = height, r = outer_diameter / 2, center = false);
  cylinder(h = height + 0.1, r = inner_diameter / 2, center = false);

  for (i = [0:50:100]) {
    rotate([0, 0, i * 180 / 100]) {
      translate([outer_diameter / 2, 0, 0]) {
        linear_extrude(height = thread_depth, convexity = 10) {
          circle(r = inner_diameter / 2);
        }
      }
    }
  }
}