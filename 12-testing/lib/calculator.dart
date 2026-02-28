class Calculator {
  int add(int a, int b) => a + b;
  int divide(int a, int b) {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    return a ~/ b; // integer division
  }
}
