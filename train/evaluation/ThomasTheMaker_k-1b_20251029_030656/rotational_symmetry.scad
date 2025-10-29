// Parameters
num_rotations = 360;
width = 50;
height = 50;
depth = 30;

// Function to generate a point on a circle
rotate_point(angle) {
  x = cos(angle) * width;
  y = sin(angle) * height;
}

// Main module
module rotational_symmetry(num_rotations) {
  difference() {
    cube([width, height, depth]);
    for (i = [0:num_rotations-1]) {
      rotate_point(i * 360 / num_rotations);
    }
  }
}

// Render the rotational symmetry
rotational_symmetry(num_rotations);