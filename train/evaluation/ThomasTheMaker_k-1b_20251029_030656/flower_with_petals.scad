// Flower with petals

// Parameters
petal_width = 10;
petal_height = 5;
petal_thickness = 1;
petal_radius = 2;
center_radius = 1;
num_petals = 8;

module petal(x, y, z) {
    translate([x, y, z])
        linear_extrude(height = petal_thickness)
            circle(r = petal_radius);
}

module flower() {
    for (i = [0:num_petals - 1]) {
        petal(i * (petal_radius + center_radius), 0, 0);
    }

    for (i = [0:num_petals - 1]) {
        translate([petal_radius * i + center_radius, 0, 0])
            rotate([0, 0, i * (360 / num_petals)])
                circle(r = center_radius);
    }
}

flower();