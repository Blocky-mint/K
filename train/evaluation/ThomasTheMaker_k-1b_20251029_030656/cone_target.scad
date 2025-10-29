// Cone target

// Parameters
radius = 20;
height = 15;
segments = 50;

// Cone
difference() {
  linear_extrude(height = height, convexity = 10)
    circle(r = radius);
}