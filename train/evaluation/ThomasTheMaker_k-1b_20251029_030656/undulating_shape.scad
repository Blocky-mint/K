module undulating_shape(width, height, depth, pitch, angle, segments) {
  
  // Parameters
  width = width;
  height = height;
  depth = depth;
  pitch = pitch;
  angle = angle;
  segments = segments;

  hull() {
    for (i = [0:segments]) {
      rotate([0, 0, i * angle]) {
        translate([width * cos(i * angle), width * sin(i * angle), depth * sin(i * angle)]) {
          cube([width, height, depth]);
        }
      }
    }
  }
}

undulating_shape(width = 50, height = 50, depth = 50, pitch = 5, angle = 30, segments = 100);