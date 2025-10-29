// Parameters
drill_diameter = 3;
drill_height = 20;
wall_thickness = 0.5;
head_diameter = 6;
head_height = 2;
shank_diameter = 0.8;
shank_height = 10;

// Main body
difference() {
  cylinder(h = drill_height, r = drill_diameter / 2, $fn = 50);
  translate([0,0,-0.1])
  cylinder(h = drill_height + 0.2, r = shank_diameter / 2, $fn = 50);
}

// Head
translate([0,0,drill_height - head_height])
cylinder(h = head_height, r = head_diameter / 2, $fn = 50);

//shank
cylinder(h = shank_height, r = shank_diameter / 2, $fn = 50);