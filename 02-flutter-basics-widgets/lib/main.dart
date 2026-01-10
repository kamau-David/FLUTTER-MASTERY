import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget: has NO mutable state - given the same inputs, it always
// builds the same UI. Use this whenever a widget doesn't need to change
// itself over time (though its PARENT can still rebuild it with new data).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WidgetsShowcase(),
    );
  }
}

class WidgetsShowcase extends StatelessWidget {
  const WidgetsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold gives you the basic Material Design page structure:
    // app bar, body, floating action button, etc.
    return Scaffold(
      appBar: AppBar(title: const Text('Core Widgets')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text: the most basic widget - displays a string
            Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16), // SizedBox: a simple box for spacing

            // Container: a box you can style (color, padding, margin, border)
            _ContainerExample(),
            SizedBox(height: 16),

            // Icon: built-in Material icons
            Icon(Icons.favorite, color: Colors.red, size: 40),
            SizedBox(height: 16),

            // Buttons: three common variants
            _ButtonExamples(),
          ],
        ),
      ),
    );
  }
}

class _ContainerExample extends StatelessWidget {
  const _ContainerExample();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text('A styled Container'),
    );
  }
}

class _ButtonExamples extends StatelessWidget {
  const _ButtonExamples();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ElevatedButton(
          onPressed: () => debugPrint('Elevated pressed'),
          child: const Text('Elevated'),
        ),
        OutlinedButton(
          onPressed: () => debugPrint('Outlined pressed'),
          child: const Text('Outlined'),
        ),
        TextButton(
          onPressed: () => debugPrint('Text pressed'),
          child: const Text('Text'),
        ),
      ],
    );
  }
}
