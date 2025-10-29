// Spring parameters
radius = 10;
wire_radius = 2;
height = 50;
turns = 5;
angle_increment = 360 / turns;

module spring(radius, wire_radius, height, turns, angle_increment) {
  for (i = [0:turns-1]) {
    angle = i * angle_increment;
    rotate([0,0,angle])
    translate([radius * cos(angle), radius * sin(angle), height * i/turns])
    cylinder(h = height, r = wire_radius, $fn = 50);
  }
}

spring(radius, wire_radius, height, turns, angle_increment);