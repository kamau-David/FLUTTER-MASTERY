import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier holds state and exposes explicit methods to change it -
// unlike Provider's ChangeNotifier, state updates are IMMUTABLE (you
// assign a whole new value to `state`, rather than mutating in place).
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0); // initial state = 0

  void increment() => state = state + 1;
  void decrement() => state = state - 1;
  void reset() => state = 0;
}

// The provider itself - a GLOBAL, but safely so: Riverpod scopes it to
// the ProviderScope in main.dart, and it's fully testable/overridable
// without needing a BuildContext (unlike Provider's package).
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
