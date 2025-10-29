// Adapter parameters
adapter_diameter = 50;
adapter_height = 20;
hole_diameter = 25;
wall_thickness = 3;

// Main body
difference() {
  cylinder(h = adapter_height, r = adapter_diameter / 2, $fn = 50);
  cylinder(h = adapter_height + 1, r = hole_diameter / 2, center = true, $fn = 50);
}