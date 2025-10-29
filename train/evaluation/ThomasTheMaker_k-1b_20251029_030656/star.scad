$fn = 60;

module star(outer_radius, inner_radius, height) {
  hull() {
    translate([outer_radius, 0, 0])
    sphere(r = inner_radius);
    translate([outer_radius, 0, 0])
    sphere(r = inner_radius);
    for (i = [0:3]) {
      translate([outer_radius * cos(i * 360 / 3), outer_radius * sin(i * 360 / 3), height * i / 3])
      rotate([0,0,90])
      translate([0,0,0])
      cube([1,1,1],center=true);
    }
  }
}

star(outer_radius = 10, inner_radius = 2, height = 1);