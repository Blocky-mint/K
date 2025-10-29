// Parameters
radius = 10;
width = 20;
height = 5;
wall_thickness = 1;
chamfer_radius = 2;

module julia_set(r, w, h, tt, cr) {
    difference() {
        cylinder(h = h, r = r, $fn = 60);
        translate([0, 0, -1])
            cylinder(h = h + 2, r = r - tt, $fn = 60);
    }
    
    // Chamfered edges
    for (i = [0:3]) {
        translate([0, 0, i * (height / 4)]) {
            linear_extrude(height = height / 4)
                polygon([
                    [0, 0],
                    [w / 2, cr],
                    [w, cr]
                ]);
        }
    }
}

julia_set(radius, width, height, wall_thickness, chamfer_radius);