// Parameters
radius = 10;
thickness = 1;
turns = 10;
angle_increment = 360 / turns;
spacing = 2;

module rotating_pattern(radius, thickness, turns, angle_increment, spacing) {
  for (i = [0:turns-1]) {
    angle = i * angle_increment;
    rotate([0,0,angle])
    translate([radius * cos(angle), radius * sin(angle), 0])
    circle(r = thickness/2, $fn=32);
  }
}

rotating_pattern(radius, thickness, turns, angle_increment, spacing);