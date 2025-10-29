// Hybrid Shape Generator

// Parameters
shape_length = 50;
shape_width = 50;
shape_height = 30;
curve_radius_base = 20;
curve_radius_top = 25;
curve_angle_base = 20;
curve_angle_top = 15;
detail = 20;

// Base Curve
linear_extrude(height = shape_height)
{
  rotate_extrude(convexity = 10)
  {
    polygon(points = [
      [0, 0],
      [shape_length, 0],
      [shape_length, curve_radius_base],
      [0, curve_radius_base]
    ]);
  }
}

// Top Curve
linear_extrude(height = curve_height)
{
  rotate_extrude(convexity = 10)
  {
    polygon(points = [
      [0, 0],
      [shape_width, 0],
      [shape_width, curve_radius_top],
      [0, curve_radius_top]
    ]);
  }
}

// Combine the curves
difference() {
  linear_extrude(height = shape_height)
  {
    rotate_extrude(convexity = 10)
    {
      linear_extrude(height = curve_height)
      {
        polygon(points = [
          [0, 0],
          [shape_length, 0],
          [shape_length, curve_radius_top],
          [0, curve_radius_top]
        ]);
      }
    }
  }

  linear_extrude(height = curve_height)
  {
    rotate_extrude(convexity = 10)
    {
      linear_extrude(height = shape_height)
      {
        polygon(points = [
          [0, 0],
          [shape_width, 0],
          [shape_width, curve_radius_top],
          [0, curve_radius_top]
        ]);
      }
    }
  }
}