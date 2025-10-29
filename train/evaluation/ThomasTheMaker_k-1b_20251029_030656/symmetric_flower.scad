// Flower Parameters
petal_radius = 10;
petal_height = 5;
petal_number = 8;
center_radius = 4;
center_height = 3;
stem_radius = 2;
stem_height = 15;
stem_segments = 16;

module petal(radius, height) {
  difference() {
    translate([radius, 0, 0])
    sphere(height);
    translate([0, -1, 0])
    cylinder(h = height, r = radius * 0.8);
  }
}

module flower() {
  for (i = [0:petal_number - 1]) {
    rotate([0, 0, i * 360 / petal_number]) {
      translate([center_radius, 0, 0]) {
        petal(center_radius, petal_height);
      }
    }
  }

  for (i = [0:stem_segments - 1]) {
    cylinder(r = stem_radius, h = stem_height, $fn = stem_segments);
  }

  translate([0, 0, 0])
  cylinder(r = stem_radius, h = stem_height, $fn = stem_segments);
}

flower();