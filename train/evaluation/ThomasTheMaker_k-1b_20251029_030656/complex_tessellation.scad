// Tessellation parameters
num_slices = 50;
tile_size = 10;
tile_thickness = 2;
rounding_radius = 0.5;

module tile(x, y, z, num_slices) {
  difference() {
    cube([tile_size, tile_size, tile_thickness]);
    translate([round(x / tile_size), round(y / tile_size), round(z / tile_size)])
    cube([tile_size - 2 * rounding_radius, tile_size - 2 * rounding_radius, tile_thickness - 2 * rounding_radius]);
  }

  for (i = [0:num_slices - 1]) {
    translate([0, 0, 0]) {
      tile(i * tile_size, i * tile_size, 0, i * tile_size);
    }
  }
}

tile(0, 0, 0, num_slices);