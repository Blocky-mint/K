// Length
length = 50;

// Radius
radius = 10;

// Offset from center
offset = length;

difference() {
  union() {
    // Main body
    cube([length, length, length]);

    // Offset
    translate([offset, offset, offset])
    cube([length, length, length]);
  }
}