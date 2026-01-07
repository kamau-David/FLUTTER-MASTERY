void main() {
  // Dart is statically typed but supports type inference with `var`
  var name = 'David'; // inferred as String
  int age = 25;
  double price = 19.99;
  bool isActive = true;

  print('$name is $age years old'); // string interpolation

  // NULL SAFETY: Dart's biggest feature since Dart 2.12. By default, a
  // variable CANNOT be null unless you explicitly mark its type nullable.
  String nonNullable = 'always has a value'; // cannot ever be null
  String? nullable = null; // the ? makes it nullable - allowed

  // The compiler forces you to handle nulls before use:
  print(nullable?.length); // ?. = safe access, returns null if nullable is null
  print(nullable ?? 'default value'); // ?? = fallback if left side is null

  // `late` promises the compiler "this will be set before it's used" -
  // useful when a value is set in initState() rather than at declaration.
  late String description;
  description = 'Set later, but before first use';
  print(description);

  // The ! operator ("bang") force-asserts a nullable value is NOT null.
  // Use sparingly - it throws at runtime if you're wrong.
  String? maybeNull = 'definitely not null this time';
  print(maybeNull!.toUpperCase());
}
