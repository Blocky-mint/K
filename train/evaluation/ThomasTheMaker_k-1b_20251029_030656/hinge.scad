// Hinge Parameters
width = 20;
height = 30;
thickness = 5;
pin_diameter = 6;
pin_length = 25;
hole_diameter = pin_diameter + 2;

module hinge_leaf(width, height, thickness) {
  difference() {
    cube([width, height, thickness]);
    translate([width/4, height/4, thickness/2])
    cube([width/2, height/2, thickness]);
  }
}

module hinge() {
  difference() {
    translate([0, 0, -0.1]) {
      hinge_leaf(width, height, thickness);
      translate([width/2, height/2, 0]) {
        cylinder(h = height, d = pin_diameter, $fn = 50);
      }
    }
    translate([0, 0, -0.1]) {
      cylinder(h = height, d = pin_diameter, $fn = 50);
    }
  }
}

translate([0, 0, 0]) {
  hinge();
}

translate([0,0,-1]) {
  hinge();
}

translate([0,0,0]) {
  hinge();
}

translate([0,0,-2]) {
  hinge();
}