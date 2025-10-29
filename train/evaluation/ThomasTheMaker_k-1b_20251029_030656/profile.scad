module profile(height, width, depth, angle = 0, radius = 1) {
  difference() {
    cube([width, depth, height]);
    rotate([0,0,angle])
      translate([0,0,-height/2])
      cylinder(h=height, r1=radius, r2=radius * 0.7, center=true);
  }
}

profile(height=10, width=20, depth=5, angle=30, radius=1);