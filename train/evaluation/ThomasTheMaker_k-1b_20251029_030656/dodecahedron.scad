module dodecahedron(radius, height) {
  for (i = [0:5]) {
    angle = i * 360 / 5;
    translate([cos(angle), sin(angle), height * i / 5])
    rotate([0, 0, angle])
    sphere(radius);
  }
}

dodecahedron(radius = 10, height = 10);