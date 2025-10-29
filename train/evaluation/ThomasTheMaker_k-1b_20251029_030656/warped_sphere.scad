module warped_sphere(r, angle, segments) {
  rotate_extrude(angle = angle, convexity = 10, $fn = segments)
    circle(r = r);
}

// Example usage:
warp_radius = 10;
warp_angle = 10;
warp_segments = 50;

warped_sphere(warp_radius, warp_angle, warp_segments);