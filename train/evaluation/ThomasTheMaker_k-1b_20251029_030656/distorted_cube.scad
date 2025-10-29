// Distorted Cube

module distorted_cube(size = 20, distortion = 0.1) {
  difference() {
    cube([size, size, size]);
    
    translate([size * 0.2, size * 0.2, size * 0.2])
    rotate([0, 0, 45])
    cylinder(h = size * 0.3, r = size * 0.1);
    
    translate([size * 0.2, size * 0.2, size * 0.2])
    rotate([0, 0, -45])
    cylinder(h = size * 0.3, r = size * 0.1);
    
    translate([size * 0.2, size * 0.2, size * 0.2])
    rotate([0, 0, -45])
    cylinder(h = size * 0.3, r = size * 0.1);
    
    translate([size * 0.2, size * 0.2, size * 0.2])
    rotate([0, 0, 45])
    cylinder(h = size * 0.3, r = size * 0.1);
  }
}

distorted_cube(size = 30, distortion = 0.2);