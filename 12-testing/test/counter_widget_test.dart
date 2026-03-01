import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_demo/counter_widget.dart';

// Widget tests: render a widget in a simulated environment ("pump" it),
// interact with it, and assert on what's actually displayed - much faster
// than a full integration test on a real device/emulator.
void main() {
  testWidgets('CounterWidget increments when button is tapped', (WidgetTester tester) async {
    // pumpWidget builds the widget tree, wrapped in MaterialApp since
    // CounterWidget uses Material widgets (ElevatedButton) that need that ancestor.
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CounterWidget())),
    );

    // Assert initial state
    expect(find.text('Count: 0'), findsOneWidget);

    // Simulate a tap, then pump() to process the resulting setState/rebuild
    await tester.tap(find.byKey(const Key('increment-button')));
    await tester.pump();

    expect(find.text('Count: 1'), findsOneWidget);
    expect(find.text('Count: 0'), findsNothing);

    // Tap twice more to verify it keeps incrementing correctly
    await tester.tap(find.byKey(const Key('increment-button')));
    await tester.tap(find.byKey(const Key('increment-button')));
    await tester.pump();

    expect(find.text('Count: 3'), findsOneWidget);
  });
}
