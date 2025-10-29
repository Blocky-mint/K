module truncate(width, height, length, angle) {
    linear_extrude(height = height)
    polygon(points = [
        [0, 0],
        [width * cos(angle), width * sin(angle)],
        [width * cos(360 - angle), width * sin(360 - angle)],
        [width * cos(720 - angle), width * sin(720 - angle)],
        [width * cos(1440 - angle), width * sin(1440 - angle)],
        [width * cos(2160 - angle), width * sin(2160 - angle)],
        [width * cos(2880 - angle), width * sin(2880 - angle)]
    ]);
}

width = 20;
height = 10;
length = 10;
angle = 360 / 4;

translate([0,0,-length/2])
truncate(width, height, length, angle);