// Basic function
int add(int a, int b) => a + b; // arrow syntax for single-expression functions

// Named parameters (curly braces) - great for readability with many params.
// {required X} forces the caller to provide it.
String greet({required String name, String greeting = 'Hello'}) {
  return '$greeting, $name!';
}

// Positional optional parameters (square brackets)
String formatPrice(double amount, [String currency = 'KES']) {
  return '$currency ${amount.toStringAsFixed(2)}';
}

// Functions are first-class values in Dart - can be passed around
int applyOperation(int a, int b, int Function(int, int) operation) {
  return operation(a, b);
}

void main() {
  print(add(2, 3));
  print(greet(name: 'David'));
  print(greet(name: 'David', greeting: 'Hi'));
  print(formatPrice(1200));
  print(formatPrice(1200, 'USD'));

  // Passing a function as an argument, and an inline anonymous function
  print(applyOperation(4, 5, add));
  print(applyOperation(4, 5, (a, b) => a * b));
}
