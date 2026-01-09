// A Future represents a value that will be available LATER - Dart's
// equivalent of a JavaScript Promise. Same async/await syntax as JS too.

Future<String> fetchUserName() {
  return Future.delayed(const Duration(seconds: 1), () => 'David');
}

Future<List<String>> fetchOrders(String userName) {
  return Future.delayed(const Duration(seconds: 1), () => ['Order1', 'Order2']);
}

Future<void> main() async {
  print('Starting...');

  // await pauses execution until the Future completes, without blocking
  // the whole app (Dart's event loop keeps running other work meanwhile -
  // this matters a lot in Flutter, where the UI must stay responsive).
  final userName = await fetchUserName();
  print('Got user: $userName');

  final orders = await fetchOrders(userName);
  print('Got orders: $orders');

  // Running two independent Futures in PARALLEL instead of sequentially
  print('\nRunning two fetches in parallel...');
  final results = await Future.wait([
    fetchUserName(),
    fetchOrders('someone'),
  ]);
  print('Both done: $results');

  // try/catch works normally with async/await for error handling
  try {
    await Future.delayed(const Duration(milliseconds: 500), () => throw Exception('Simulated failure'));
  } catch (e) {
    print('Caught error: $e');
  }
}
