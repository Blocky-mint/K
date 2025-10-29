$fn = 50;

module donut(radius, height, segments) {
  difference() {
    rotate_extrude(angle = 360, $fn = $fn)
    translate([radius, 0, 0])
    circle(r = radius);

    rotate_extrude(angle = 360, $fn = $fn)
    translate([radius, 0, 0])
    circle(r = radius);
  }
}

donut(radius = 20, height = 10, segments = 100);