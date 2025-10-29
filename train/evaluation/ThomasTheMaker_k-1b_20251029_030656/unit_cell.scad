module unit_cell(size, thickness, cell_size) {
  difference() {
    cube([size, size, thickness]);
    translate([size/4, size/4, thickness/4])
    cube([size/2, size/2, thickness/2]);
  }
}

unit_cell(size = 100, thickness = 20, cell_size = 50);