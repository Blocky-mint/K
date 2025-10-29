// Mandelbrot set parameters
width = 50;
height = 50;
radius = 25;

// Function to calculate the Mandelbrot set value at a given radius
function mandelbrot(radius) =
  if (radius <= 0) {
    return 0;
  } else {
    $fn = 256;
    x = radius * cos(360 * pi / $fn);
    y = radius * sin(360 * pi / $fn);
    
    mandelbrot(x) + mandelbrot(y)
  }

// Create the mandelbrot shape
mandelbrot(radius);