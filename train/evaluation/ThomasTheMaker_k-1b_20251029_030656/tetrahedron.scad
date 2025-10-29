// Tetrahedron defined by three points
// A, B, C, D where A(0,0), B(1,0), C(0.5, 1), D(-0.5, -0.5)

module tetrahedron(a, b, c, d) {
  
  // Function to calculate distance between two points
  function distance(p1, p2) = sqrt(pow(p1[0] - p2[0], 2) + pow(p1[1] - p2[1], 2));

  // First tetrahedron
  translate([a[0], a[1], a[2]]) {
    rotate([0, 0, 45]) {
      translate([0, 0, 0]) {
        linear_extrude(height = 0.1) {
          polygon([[1, 0], [0, 1], [0.5, 0.5]]);
        }
      }
    }
  }

  // Second tetrahedron
  translate([b[0], b[1], b[2]]) {
    rotate([0, 0, -45]) {
      translate([0, 0, 0]) {
        linear_extrude(height = 0.1) {
          polygon([[1, 0], [0, 1], [0.5, 0.5]]);
        }
      }
    }
  }

  // Third tetrahedron
  translate([c[0], c[1], c[2]]) {
    rotate([0, 0, -45]) {
      translate([0, 0, 0]) {
        linear_extrude(height = 0.1) {
          polygon([[1, 0], [0, 1], [0.5, 0.5]]);
        }
      }
    }
  }
  
  // Fourth tetrahedron
  translate([d[0], d[1], d[2]]) {
    rotate([0, 0, -45]) {
      translate([0, 0, 0]) {
        linear_extrude(height = 0.1) {
          polygon([[1, 0], [0, 1], [0.5, 0.5]]);
        }
      }
    }
  }
}

// Call the tetrahedron module
tetrahedron(a, b, c, d);