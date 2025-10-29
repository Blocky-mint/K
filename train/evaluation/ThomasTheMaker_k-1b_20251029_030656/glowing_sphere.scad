// Parameters
radius = 10;
inner_radius = 2;
glow_intensity = 0.2;
glow_radius = 0.5;

difference() {
  sphere(r = radius);
  translate([0, 0, -inner_radius]) {
    sphere(r = glow_radius);
  }

  translate([0, 0, 0]) {
    cube([radius * 2, radius * 2, radius * 2], center = true);
  }
}