module interlocking_piece(width, height, depth, hole_diameter, wall_thickness) {
  difference() {
    cube([width, height, depth]);
    translate([wall_thickness, wall_thickness, wall_thickness])
    cube([width - 2 * wall_thickness, height - 2 * wall_thickness, depth - 2 * wall_thickness]);

    if (hole_diameter > 0) {
      translate([width/2 - hole_diameter/2, height/2 - hole_diameter/2, depth/2 - hole_diameter/2])
      cylinder(h=hole_diameter, r=hole_diameter/2);
    }
  }
}

interlocking_piece(width=50, height=50, depth=25, hole_diameter=8, wall_thickness=2);