// Icosahedron in OpenSCAD

$fn = 60;

module icosahedron(height) {
  difference() {
    sphere(r = height/2);
    translate([0,0,-height/4])
    cylinder(h = height/4, r = height/8);
  }
}

icosahedron(height = 50);