module torus(r1, r2, $fn=10) {
  rotate_extrude(angle = 360, convexity = $fn)
    translate([r1, 0, 0])
    circle(r = r2);
}

torus(r1 = 5, r2 = 2);