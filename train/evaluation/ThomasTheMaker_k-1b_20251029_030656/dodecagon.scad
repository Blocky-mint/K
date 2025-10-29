// Dodecagon in OpenSCAD

$fn = 60;

module dodecagon(radius, height) {
  rotate_extrude(angle = 360)
    translate([radius, 0, 0])
      circle(r = radius * cos(360 / 100));
}

difference() {
  translate([0, 0, -1])
  {
    for (i = [0:5]) {
      rotate([0, 0, i * 360 / 5]) {
        translate([radius * 0.6, 0, 0])
          dodecagon(radius, height / 2);
      }
    }
  }

  for (i = [0:5]) {
    rotate([0, 0, i * 360 / 5]) {
      translate([radius * 0.6, 0, 0])
        dodecagon(radius, height / 2);
    }
  }
}