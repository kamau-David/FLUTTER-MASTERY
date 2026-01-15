import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Navigator.push adds a new screen on top of the stack.
            // MaterialPageRoute gives the standard platform transition animation.
            // We pass data FORWARD via the constructor, and await a result
            // that comes BACK when the pushed screen pops itself.
            final result = await Navigator.push<String>(
              context,
              MaterialPageRoute(builder: (context) => const DetailPage(itemName: 'Widget A')),
            );
            if (context.mounted && result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Returned: $result')),
              );
            }
          },
          child: const Text('Go to Detail'),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String itemName;
  const DetailPage({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(itemName)),
      body: Center(
        child: ElevatedButton(
          // Navigator.pop removes THIS screen from the stack, optionally
          // returning a value to whoever called push() and is awaiting it.
          onPressed: () => Navigator.pop(context, 'Confirmed from $itemName'),
          child: const Text('Confirm and go back'),
        ),
      ),
    );
  }
}
