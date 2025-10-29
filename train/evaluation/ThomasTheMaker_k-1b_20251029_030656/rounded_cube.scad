module rounded_cube(size, radius) {
  difference() {
    cube([size, size, size]);
    translate([radius, radius, radius])
    cylinder(h = size, r = radius, $fn = 50);
    translate([size - radius, radius, radius])
    cylinder(h = size, r = radius, $fn = 50);
    translate([radius, size - radius, radius])
    cylinder(h = size, r = radius, $fn = 50);
    translate([size - radius, size - radius, radius])
    cylinder(h = size, r = radius, $fn = 50);
  }
  
  rounded_cube([50, 50, 50], 10);
}