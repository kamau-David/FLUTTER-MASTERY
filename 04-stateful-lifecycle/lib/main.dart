import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const CounterPage());
  }
}

// StatefulWidget: needed whenever a widget must hold data that CHANGES
// over its lifetime in response to user interaction, timers, streams, etc.
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  Timer? _timer;
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    // initState runs ONCE, when the widget is first inserted into the tree.
    // Perfect place to start timers, subscribe to streams, or fetch initial data.
    debugPrint('initState: starting timer');
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _increment() {
    // setState() tells Flutter "some data used in build() has changed,
    // please rebuild this widget." Without calling setState(), _counter
    // would change internally but the UI would NEVER update - a very
    // common beginner bug.
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    // dispose runs when the widget is permanently removed from the tree.
    // ALWAYS cancel timers/subscriptions here, or you get a memory leak:
    // the timer keeps firing and calling setState() on a widget that no
    // longer exists, which throws an error.
    debugPrint('dispose: cancelling timer');
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // build() runs every time setState() is called - keep it FAST and
    // side-effect-free. Never call setState() directly inside build()
    // (infinite rebuild loop) or do heavy work here.
    debugPrint('build: counter=$_counter, seconds=$_secondsElapsed');
    return Scaffold(
      appBar: AppBar(title: const Text('Lifecycle Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $_counter', style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            Text('Seconds elapsed: $_secondsElapsed', style: const TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
