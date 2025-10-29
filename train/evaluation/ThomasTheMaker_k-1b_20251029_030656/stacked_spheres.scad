module sphere(r) {
  sphere(r);
}

module stacked_spheres(num_spheres, height) {
  for (i = [0:num_spheres-1]) {
    translate([i * height, 0, 0]) {
      sphere(r);
    }
  }
}

stacked_spheres(5, 10);