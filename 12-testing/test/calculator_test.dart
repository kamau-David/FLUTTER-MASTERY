import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/calculator.dart';

// Unit tests: no Flutter widgets involved, just plain Dart logic - these
// run fast and are the majority of tests in a well-tested app.
void main() {
  group('Calculator', () {
    final calculator = Calculator();

    test('adds two numbers', () {
      expect(calculator.add(2, 3), 5);
    });

    test('divides two numbers', () {
      expect(calculator.divide(10, 2), 5);
    });

    test('throws when dividing by zero', () {
      expect(() => calculator.divide(10, 0), throwsArgumentError);
    });
  });
}
