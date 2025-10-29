// Ripple parameters
radius = 10;
height = 5;
frequency = 1;
amplitude = 1;

module ripple(radius, height, frequency, amplitude) {
  difference() {
    cylinder(h = height, r = radius, $fn = 60);
    translate([0, 0, height/2])
      linear_extrude(height = height/2)
        rotate([0,0,45])
          scale([1,1,1])
            cube([radius*2, radius*2, height]);
  }
}

ripple(radius, height, frequency, amplitude);