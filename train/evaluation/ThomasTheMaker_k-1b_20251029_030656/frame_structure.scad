// Frame Structure Parameters
frame_width = 50;
frame_height = 80;
frame_depth = 20;
wall_thickness = 2;
corner_radius = 3;

module frame(width, height, depth, thickness, radius) {
  difference() {
    cube([width, height, depth]);
    translate([thickness, thickness, thickness])
      cube([width - 2 * thickness, height - 2 * thickness, depth - 2 * thickness]);
    translate([0, 0, 0])
      cylinder(r=radius, h=height, $fn=32);
    translate([width - radius, 0, depth - radius])
      cylinder(r=radius, h=height, $fn=32);
    translate([0, height - radius, 0])
      cylinder(r=radius, h=width, $fn=32);
    translate([width - radius, height - radius, 0])
      cylinder(r=radius, h=depth, $fn=32);
    translate([0, 0, depth - radius])
      cylinder(r=radius, h=width, $fn=32);
  }
}

frame(frame_width, frame_height, frame_depth, wall_thickness, corner_radius);