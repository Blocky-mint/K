$fn = 64;

sphere_r = 1;
scale = 1;

difference() {
  sphere(r);
  sphere(r * scale);
}