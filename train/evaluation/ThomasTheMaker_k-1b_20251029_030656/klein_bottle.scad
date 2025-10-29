// Klein Bottle Parameters
bottle_height = 70;
bottle_diameter = 30;
neck_height = 15;
neck_diameter = 15;
wall_thickness = 2;
base_radius = 15;
base_height = 2;

// Function to create a 2D surface
module klein_bottle_surface(height, diameter, radius) {
  linear_extrude(height = height, convexity = 10)
    polygon([[radius, 0],
              [radius * cos(360 - 45), radius * sin(360 - 45)],
              [0, radius]]);
}

module bottle() {
  difference() {
    // Main body
    linear_extrude(height = bottle_height - neck_height - wall_thickness) {
      min(diameter, diameter - wall_thickness)
        linear_extrude(height = 2);
      linear_extrude(height = 2);
      cylinder(h = 2, r = diameter/2 - wall_thickness);
    }

    // Neck
    translate([0, 0, -neck_height])
      linear_extrude(height = neck_height)
        polygon([[neck_diameter/2, 0],
                  [neck_diameter/2, 0]]);

    // Base
    translate([0, 0, -base_height])
      linear_extrude(height = base_height)
        circle(r = base_radius);
  }
}

// Render the bottle
bottle();