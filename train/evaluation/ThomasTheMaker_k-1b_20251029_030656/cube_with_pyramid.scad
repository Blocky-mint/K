$fn = 60;

module cube(size) {
  cube(size);
}

module pyramid(base_height, height_offset) {
  translate([0,0,0]) {
    linear_extrude(height = height_offset) {
      polygon(points=[[0,0], [size, size*0.1], [0,size]]);
    }
  }
}

difference() {
  cube([10,10,10]);
  translate([0,0,-1]) pyramid([5,5,1]);
}