module bent_cylinder(height, radius1, radius2, twist_angle) {
  difference() {
    cylinder(h = height, r = radius1);
    translate([0, 0, height]) {
      rotate([0, 0, twist_angle]) {
        cylinder(h = height, r = radius2);
      }
    }
  }
}

// Example usage:
bent_cylinder(height = 20, radius1 = 5, radius2 = 3, twist_angle = 30);