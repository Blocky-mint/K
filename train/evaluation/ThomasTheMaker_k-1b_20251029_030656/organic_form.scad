// Parameters
radius = 50;
height = 100;
resolution = 32;
segments_per_angle = 12;
segments_per_height = 32;
taper_angle = 50;

module organic_form(radius, height, segments, resolution, taper_angle) {
  linear_extrude(height = height, convexity = 10, slices = resolution) {
    polygon(points=[
      [radius, 0],
      [radius * cos(taper_angle), radius * sin(taper_angle)],
      [radius * cos(taper_angle) * 0.8, radius * sin(taper_angle) * 0.8],
      [radius * cos(taper_angle) * 0.3, radius * sin(taper_angle) * 0.3],
      [radius * cos(taper_angle) * 0.8, radius * sin(taper_angle) * 0.3],
      [radius * cos(taper_angle) * 0.3, radius * sin(taper_angle) * 0.3],
      [0, 0]
    ]);
  }
}

organic_form(radius, height, resolution, taper_angle);