// Sphere Head - OpenSCAD

// Parameters
r = 50;  // Radius of the sphere
segments = 64; // Number of segments for smoother curves
rings = 24;  // Resolution for rings

// Function to create a sphere with a specified radius and segments
module sphere(r, segments, rings) {
    linear_extrude(height = 1) {
        circle(r = r);
    }
}

// Create the sphere head
sphere(r = r, segments = segments, rings = rings);