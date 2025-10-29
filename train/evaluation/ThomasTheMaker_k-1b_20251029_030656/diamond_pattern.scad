module diamond(size, height) {
  linear_extrude(height = height)
  polygon(points = [
    [size * cos(0), size * sin(0)],
    [size * cos(360), size * sin(360)],
    [size * cos(720), size * sin(720)],
    [size * cos(1080), size * sin(1080)],
    [size * cos(1440), size * sin(1440)],
    [size * cos(1800), size * sin(1800)],
    [size * cos(2160), size * sin(2160)],
    [size * cos(2520), size * sin(2520)],
    [size * cos(2880), size * sin(2880)],
    [size * cos(3240), size * sin(3240)],
    [size * cos(3600), size * sin(3600)]
  ]);
}

diamond(size = 10, height = 1);