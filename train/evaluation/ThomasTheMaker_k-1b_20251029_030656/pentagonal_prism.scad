module pentagonal_prism(width, height, depth) {
  linear_extrude(height = depth)
  polygon(points=[[0,0], [width/2, height], [width/2, -height], [0, -height], [width/2, -height]]);
}

pentagonal_prism(width = 20, height = 10, depth = 5);