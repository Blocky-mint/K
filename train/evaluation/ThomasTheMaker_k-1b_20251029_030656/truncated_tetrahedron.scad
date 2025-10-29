module truncated_tetrahedron(size) {
  translate([0,0,0]) {
    linear_extrude(height = size[0]) {
      polygon(points = [
        [size[0]/2, 0],
        [size[0]/2, size[1/2]],
        [size[0]/2, size[1]],
        [size[0]/2, -size[1/2]]
      ]);
    }
  }
}

truncated_tetrahedron(size = 100);