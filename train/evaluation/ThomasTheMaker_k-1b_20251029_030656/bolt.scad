// Bolt parameters
head_diameter = 10;
head_height = 3;
shank_diameter = 20;
shank_length = 30;
thread_diameter = 8;
thread_pitch = 1.25;
total_length = shank_length + head_height;

module bolt_head() {
  difference() {
    cylinder(h = head_height, d = head_diameter, center = true);
    translate([0,0,head_height/2]) cylinder(h = 2, d = head_diameter/2, center = true);
  }
  translate([0,0,-head_height/2]) rotate([0,0,90]) cylinder(h = 2, d = thread_diameter, center = true);
}

module bolt_shank() {
  cylinder(h = shank_length, d = shank_diameter, center = true);
}

module bolt() {
  translate([0,0,0]) bolt_head();
  translate([0,0,-shank_length/2]) bolt_shank();
}

// Render the bolt
bolt();