// Create a cube
module cube(size) {
    cube([size[0], size[1], size[2]]);
}

// Create a sphere
module sphere_cube(size) {
    sphere(size);
}

// Create a sphere cube
module sphere_cube_with_spheres(size) {
    cube([size[0], size[1], size[2]]);
}

// Example usage
// sphere_cube_with_spheres([10, 10, 10]);

//cube([100,100,100]);
cube([100,100,100]);