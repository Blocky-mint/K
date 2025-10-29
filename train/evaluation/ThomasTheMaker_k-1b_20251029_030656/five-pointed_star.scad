// Parameters
point_radius = 2;
point_height = 1;
point_angle = 15;
points = 5;
inner_radius = 1;

module point(angle, radius) {
  rotate([0, 0, angle])
  translate([radius, 0, 0])
  linear_extrude(height = 0.1) circle(r = radius);
}

difference() {
  for (i = [0:points - 1]) {
    angle = i * 360 / points;
    translate([
      point_radius * cos(angle),
      point_radius * sin(angle),
      -point_height/2
    ]) {
      point(angle, point_radius);
    }
  }
  
  translate([0,0,-inner_radius])
  cube([point_radius*2,point_radius*2,inner_radius*2]);
}