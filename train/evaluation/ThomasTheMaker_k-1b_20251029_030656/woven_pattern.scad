// Parameters for the woven pattern
num_weaves = 10;
weave_height = 10;
weave_width = 5;
weave_spacing = 2;
knot_width = 0.5;
knot_height = 2;
knot_offset = 2;

module weave(x, y) {
  translate([x, y, 0])
  cube([weave_width, weave_height, knot_width]);
}

module woven_pattern() {
  for (i = [0:num_weaves - 1]) {
    weave(i * (weave_width + weave_spacing), 0);
  }
}

woven_pattern();