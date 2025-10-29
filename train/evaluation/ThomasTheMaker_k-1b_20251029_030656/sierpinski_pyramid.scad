module sierpinski_pyramid(height, layers, radius) {
  hull() {
    for (i = [0:layers - 1]) {
      rotate([0, 0, i * 360 / layers]) {
        translate([radius * cos(i * 360 / layers), radius * sin(i * 360 / layers), height * (layers - 1) / 2]) {
          polygon(points = [[0, 0], [0, 1], [1, 1], [1, 0]]);
        }
      }
    }
  }
  difference() {
    hull() {
        for (i = [0:layers - 1]) {
            rotate([0, 0, i * 360 / layers]) {
                translate([radius * cos(i * 360 / layers), radius * sin(i * 360 / layers), height * (layers - 1) / 2]) {
                    polygon(points = [[0, 0], [0, 1], [1, 1], [1, 0]]);
                }
            }
        }
    }
    difference() {
        translate([0,0,height])
        hull() {
            for (i = [0:layers - 1]) {
                rotate([0, 0, i * 360 / layers]) {
                    translate([radius * cos(i * 360 / layers), radius * sin(i * 360 / layers), height * (layers - 1) / 2]) {
                        polygon(points = [[0, 0], [0, 1], [1, 1], [1, 0]]);
                    }
                }
            }
        }
    }
  }
}

sierpinski_pyramid(height = 10, layers = 10, radius = 20);