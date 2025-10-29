// Screw parameters
screw_diameter = 6;
thread_diameter = 1.2;
thread_pitch = 0.5;
head_diameter = 12;
head_height = 2;
shank_length = 20;
shank_diameter = screw_diameter;

module screw() {
  difference() {
    cylinder(h = shank_length, r = shank_diameter / 2, center = false);
    cylinder(h = shank_length, r = (screw_diameter - thread_diameter) / 2, center = false);

    for (i = [0:3]) {
      rotate([0, 0, i * 90]) {
        translate([head_diameter / 2, 0, 0]) {
          cylinder(h = thread_pitch, r = thread_diameter / 2, center = true);
        }
      }
    }
  }
}

screw();