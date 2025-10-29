// Pulley Parameters
radius = 20;
thickness = 10;
groove_radius = 10;
groove_depth = 3;
number_of_grooves = 2;
groove_angle_offset = 18; // Offset from center to groove

// Pulley Body
difference() {
  cylinder(h = thickness, r = radius, $fn = 64);
  for (i = [0:number_of_grooves-1]) {
    rotate([0, 0, i * 360 / number_of_grooves]) {
      translate([0,0,-groove_depth]) {
        cube([radius * 2, radius * 2, groove_depth], center = true);
      }
    }
  }
}

// Hole for rope passage (optional)
// cylinder(h = thickness, r = 2, $fn = 64);

// Uncomment to generate a pulley with holes

//difference() {
//  cylinder(h = thickness, r = radius, $fn = 64);
//  for (i = [0:number_of_grooves-1]) {
//    rotate([0, 0, i * 360 / number_of_grooves]) {
//      translate([0,0,-groove_depth]) {
//        cube([radius * 2, radius * 2, groove_depth], center = true);
//      }
//    }
//  }
//}