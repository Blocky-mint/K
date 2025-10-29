// Mixed Array
// Array size: 10x5
// Each element is a number between 0 and 10.

module mixed_array(size) {
  // Create an array with random numbers
  random_numbers = [random(size) for _ in range(size)];

  // Print the array
  print(random_numbers);
}

mixed_array(10);