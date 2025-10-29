// Gear parameters
module gear(
  number_of_teeth = 20,
  pitch_diameter = 10,
  width = 10,
  pressure_angle = 20,
  hole_diameter = 3,
  thickness = 2
) {
  // Calculate gear parameters
  pitch_radius = pitch_diameter / 2;
  pitch_height = pitch_radius * cos(pressure_angle);

  module tooth(pitch, height, radius) {
    rotate([0, 0, 180])
    translate([0, -radius, 0])
    linear_extrude(height = height)
    polygon(points = [
      [0, 0],
      [pitch, radius],
      [0, pitch]
    ]);
  }

  difference() {
    union() {
      for (i = [0:number_of_teeth - 1]) {
        translate([0, 0, i * (pitch_height / number_of_teeth)]) {
          tooth(pitch_radius, pitch_height, pitch_radius);
        }
      }
      cylinder(h = thickness, r = hole_diameter / 2, center = true);
    }
    
    for (i = [0:number_of_teeth - 1]) {
        translate([0, 0, i * (pitch_height / number_of_teeth)]) {
            rotate([0, 0, 180])
            translate([0, -pitch_radius, 0])
            linear_extrude(height = thickness)
            polygon(points = [
                [0, 0],
                [pitch_radius, -radius],
                [0, pitch]
            ]);
        }
    }
  }
}

gear(number_of_teeth = 20, pitch_diameter = 10, width = 10, pressure_angle = 20, hole_diameter = 3, thickness = 2);