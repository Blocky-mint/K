module octahedron(a, b) {
  difference() {
    cube([a, a, b]);
    translate([a/2, a/2, b/2])
    sphere(a/2);
    translate([-a/2, -a/2, b/2])
    sphere(a/2);
  }
}

octahedron(10, 10);