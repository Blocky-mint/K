module compressed_pyramid(height, base_width, base_depth, layer_height, layer_depth) {
  difference() {
    cube([base_width, base_depth, height]);

    for (i = [0:layer_height]) {
      translate([0, 0, i * height]) {
        cylinder(h = layer_depth, r = base_width / 2, $fn = 50);
      }
    }
  }
}

compressed_pyramid(height = 10, base_width = 20, base_depth = 20, layer_height = 5, layer_depth = 2);