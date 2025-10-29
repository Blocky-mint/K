// Bushing parameters
outer_diameter = 50;
inner_diameter = 30;
height = 20;
wall_thickness = (outer_diameter - inner_diameter) / 2;

// Create the bushing
difference() {
  cylinder(h = height, r = outer_diameter / 2, $fn = 100);
  cylinder(h = height, r = inner_diameter / 2, $fn = 100);
}