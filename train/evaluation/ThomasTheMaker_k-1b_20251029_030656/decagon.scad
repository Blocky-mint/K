// Decagon in OpenSCAD
$fn = 60;

module decagon(radius, angle_increment) {
  difference() {
    for (i = [0:7]) {
      angle = i * angle_increment;
      rotate([0, 0, angle]) {
        translate([radius * cos(angle), radius * sin(angle), 0]) {
          linear_extrude(height = 1) {
            circle(r = radius);
          }
        }
      }
    }
  }
}

decagon(radius = 10, angle_increment = 30);