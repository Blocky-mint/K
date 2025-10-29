// Cuboctahedron in OpenSCAD

// Parameters
a = 10;
b = 10;
c = 10;
d = 10;
e = 10;
f = 10;

// Cuboctahedron definition
module cuboctahedron(a, b, c, d, e, f) {
  difference() {
    cube([a, b, c]);
    translate([a/2 - b/2, b/2 - c/2, c/2 - d/2])
    cube([b, c, d]);
    translate([a/2 - b/2, c/2 - d/2, e/2 - f/2])
    cube([b, c, d]);
    translate([a/2 - b/2, e/2 - d/2, f/2 - e/2])
    cube([b, c, d]);
    translate([a/2 - b/2, e/2 - d/2, f/2 - e/2])
    cube([b, c, d]);
  }
}

cuboctahedron(a, b, c, d, e, f);