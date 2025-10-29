// Wave parameters
wavelength = 50;
amplitude = 2;
frequency = 2;
number_of_waves = 10;

module wave(amplitude, frequency, number_of_waves) {
  for (i = [0:number_of_waves - 1]) {
    angle = i * 2 * PI;
    x = amplitude * cos(angle);
    y = amplitude * sin(angle);
    translate([x, y, 0]) {
      cube([1, 1, 1], center = true);
    }
  }
}

wave(amplitude, frequency, number_of_waves);