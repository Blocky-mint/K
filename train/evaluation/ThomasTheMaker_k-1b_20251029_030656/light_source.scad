// Light Source Parameters
light_radius = 20;
light_height = 50;
light_depth = 10;
bulb_radius = 10;
bulb_height = 20;
bulb_depth = 8;

// Create the bulb
module bulb() {
  sphere(bulb_radius);
}

// Create the light source
difference() {
  union() {
    translate([0, 0, 0]) {
      bulb();
      translate([0, 0, light_height/2 - bulb_height/2]) {
        bulb();
      }
    }
  }
  translate([0, 0, -1]) {
    cube([light_radius * 2, light_radius * 2, light_depth]);
  }
}