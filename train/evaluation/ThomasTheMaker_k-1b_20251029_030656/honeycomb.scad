// Honeycomb parameters
radius = 10;
cell_width = 2;
cell_height = 2;
cell_spacing = 0.5;
num_cells = 20;

module honeycomb(radius, cell_width, cell_height, cell_spacing, num_cells) {
  for (i = [0:num_cells-1]) {
    for (j = [0:num_cells-1]) {
      translate([cell_width/2 + j * cell_spacing, cell_height/2 + i * cell_spacing, 0]) {
        difference() {
          cube([cell_width, cell_height, cell_width]);
          translate([0, 0, 0])
          cube([cell_width, cell_height, cell_width]);
        }
      }
    }
  }
}

honeycomb(radius, cell_width, cell_height, cell_spacing, num_cells);