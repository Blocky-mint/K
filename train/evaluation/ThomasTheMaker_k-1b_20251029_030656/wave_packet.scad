$fn = 50;
amplitude = 1;
frequency = 10;
width = 10;
height = 5;
depth = 3;

module wave_packet(amplitude, frequency, width, height, depth) {
    rotate_angle = 180;
    t = 0;

    for (i = [-1:1]) {
        t += i * (2 * PI * frequency);
        
        translate([0, 0, t]) {
            rotate_axis([0, 0, 90]) {
                linear_extrude(height = height) {
                    linear_extrude( convexity = 10, twist = 0) {
                        difference() {
                            circle(r = width / 2);
                            for (x = -width/2; x < width; x += width / 2) {
                                translate([x, 0, t]) {
                                    rotate([0, 0, 0]) {
                                        translate([0, 0, height]) {
                                            scale([1, 1, 1]) {
                                                linear_extrude( convexity = 10, twist = 0) {
                                                    difference() {
                                                        circle(r = width / 2);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

wave_packet(amplitude, frequency, width, height, depth);