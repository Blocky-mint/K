// Vase parameters
vase_height = 100;
vase_diameter = 80;
neck_height = 20;
neck_diameter = 60;
base_height = 10;
base_diameter = 60;
wall_thickness = 3;

module vase_body(height, diameter, wall_thickness) {
  difference() {
    cylinder(h = height, d = diameter, center = false);
    cylinder(h = height - neck_height, d = diameter - 2 * wall_thickness, center = false);
  }
}

module vase_neck(height, diameter) {
  difference() {
    cylinder(h = height, d = diameter, center = false);
    cylinder(h = height - neck_height, d = diameter - 2 * wall_thickness, center = false);
  }
}

module vase_base(diameter, height) {
  difference() {
    cylinder(h = height, d = diameter, center = false);
    cylinder(h = height - base_height, d = diameter - 2 * wall_thickness, center = false);
  }
}

difference() {
  vase_body(vase_height - neck_height - base_height, vase_diameter, wall_thickness);
  translate([0, 0, vase_height - neck_height - base_height]) vase_neck(neck_height, neck_diameter);
  translate([0, 0, vase_height - neck_height - base_height]) vase_base(base_diameter, base_height);
}