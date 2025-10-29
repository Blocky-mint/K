// Hammer parameters
handle_length = 70;
handle_radius = 15;
handle_taper_start = 30;
handle_taper_end = 10;
head_radius = 10;
head_height = 15;
shaft_diameter = 25;
shaft_length = 100;

// Handle
module handle() {
    linear_extrude(height = handle_length) {
        offset() {
            circle(r = handle_radius);
        }
    }
}

// Head
module head() {
    difference() {
        cylinder(h = head_height, r = head_radius);
        translate([0, 0, head_height - 5]) cylinder(h = 5, r = handle_radius);
    }
}

// Shaft
module shaft() {
    cylinder(h = shaft_length, r = shaft_diameter);
}

// Assembly
union() {
    // Handle
    translate([0, 0, 0]) handle();

    // Head
    translate([0, 0, handle_length - head_height]) head();

    // Shaft
    translate([0, 0, handle_length - head_height - shaft_length]) shaft();
}