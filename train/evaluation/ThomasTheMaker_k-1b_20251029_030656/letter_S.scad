module letter_s(height = 20) {
  difference() {
    hull() {
      translate([0, 0, -height/4]) sphere(r=height/10);
      translate([0, 0, height/4]) sphere(r=height/10);
      translate([0, 0, -height/4]) sphere(r=height/10);
      translate([0, 0, height/4]) sphere(r=height/10);
      translate([0, 0, height/4]) sphere(r=height/10);
    }
    translate([0, 0, height/2]) cube([height*2, height*2, height*2]);
  }
}

letter_s();