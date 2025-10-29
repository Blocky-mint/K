// Fish Model in OpenSCAD

// Parameters
fish_length = 50;
fish_width = 30;
fish_height = 15;
fin_length = 20;
fin_height = 10;
eye_radius = 3;
mouth_radius = 2;

module fish() {
  difference() {
    union() {
      // Body
      translate([0, 0, 0])
      cube([fish_length, fish_width, fish_height]);

      // Tail
      translate([fish_length - 10, -fish_width/2, fish_height])
      rotate([0, 0, 10])
      cylinder(h=fish_width, r1=fish_width/4, r2=fish_width/8);

      //Fin
      translate([fish_length - 15, 0, fish_height/2])
      rotate([0, 0, 30])
      cube([fin_length, fin_height, fin_height]);

      // Eye
      translate([fish_length/2 - eye_radius * 1.5, -fish_width/2, fish_height + 2])
      sphere(eye_radius);
      translate([fish_length/2 + eye_radius * 1.5, -fish_width/2, fish_height + 2])
      sphere(eye_radius);
    }

    // Mouth
    translate([fish_length/2 - mouth_radius * 1.5, -fish_width/2, fish_height - 3])
    cylinder(h=mouth_radius * 2, r=mouth_radius);
  }
}

fish();