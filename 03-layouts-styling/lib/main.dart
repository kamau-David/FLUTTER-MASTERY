import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layouts Demo',
      // THEME: define styling ONCE, use it everywhere via Theme.of(context) -
      // avoids repeating the same colors/fonts across every widget.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LayoutsPage(),
    );
  }
}

class LayoutsPage extends StatelessWidget {
  const LayoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layouts & Styling')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Row - horizontal layout', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(Colors.red, 'A'),
                _box(Colors.green, 'B'),
                _box(Colors.blue, 'C'),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Expanded - fills remaining space proportionally', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(flex: 2, child: _box(Colors.orange, 'flex:2')),
                Expanded(flex: 1, child: _box(Colors.purple, 'flex:1')),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Stack - overlapping widgets', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 150, height: 150, color: Colors.blue.shade100),
                  Container(width: 100, height: 100, color: Colors.blue.shade300),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.star, color: Colors.amber),
                  ),
                  const Text('Centered on top'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Column - vertical layout', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _box(Colors.teal, 'Top'),
                const SizedBox(height: 8),
                _box(Colors.teal.shade700, 'Bottom'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _box(Color color, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: color,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
