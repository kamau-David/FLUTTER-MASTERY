void main() {
  // LIST: ordered, allows duplicates
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // map(): transform every element (like JS .map)
  final doubled = numbers.map((n) => n * 2).toList();
  print('Doubled: $doubled');

  // where(): filter elements (like JS .filter)
  final evens = numbers.where((n) => n % 2 == 0).toList();
  print('Evens: $evens');

  // fold(): reduce to a single value (like JS .reduce)
  final sum = numbers.fold(0, (total, n) => total + n);
  print('Sum: $sum');

  // Chaining is idiomatic in Dart, same as JS method chains
  final result = numbers.where((n) => n > 3).map((n) => n * n).toList();
  print('Squares of numbers > 3: $result');

  // MAP (like a JS object / Python dict): key-value pairs
  Map<String, int> ages = {'David': 25, 'Grace': 30};
  ages['Faith'] = 28; // add a new entry
  print(ages);
  ages.forEach((key, value) => print('$key is $value'));

  // SET: unique values only, no duplicates
  Set<String> uniqueTags = {'flutter', 'dart', }; // duplicate ignored
  print('Unique tags: $uniqueTags');
}
