// Attachment Point Parameters
attachment_height = 20;
attachment_width = 15;
attachment_depth = 10;
hole_diameter = 3;
hole_offset_x = 5;
hole_offset_y = 2;

module attachment() {
  difference() {
    cube([attachment_width, attachment_depth, attachment_height]);
    translate([hole_offset_x, hole_offset_y, attachment_height - hole_diameter/2])
      cylinder(h = attachment_height - hole_diameter/2, r = hole_diameter/2, $fn=32);
  }
}

attachment();