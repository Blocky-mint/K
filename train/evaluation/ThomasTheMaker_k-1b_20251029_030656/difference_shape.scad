difference() {
  union() {
    // Main body
    cube([50, 50, 10]);

    // Rounded corners
    translate([0, 0, 0])
    rotate([0, 0, 10])
    cylinder(r=10, h=10, center=true);

    translate([0, 0, 0])
    rotate([0, 0, 10])
    cylinder(r=10, h=10, center=true);
  }

  // Subtract the inner cube
  translate([5, 5, 5])
  cube([30, 30, 10]);
}