import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/counter_provider.dart';
import 'providers/posts_provider.dart';

void main() {
  runApp(
    // ProviderScope MUST wrap the whole app - it's where all provider
    // state actually lives (similar role to ChangeNotifierProvider in
    // folder 09, but handles ALL providers app-wide, not just one).
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: RiverpodDemoPage());
}

// ConsumerWidget: like StatelessWidget, but its build() method receives
// a `ref` object used to read/watch providers.
class RiverpodDemoPage extends ConsumerWidget {
  const RiverpodDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch subscribes this widget to rebuild whenever counterProvider changes
    final count = ref.watch(counterProvider);
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Demo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Count: $count', style: const TextStyle(fontSize: 32)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ref.read is for one-off actions (button presses) -
                    // same distinction as context.read vs context.watch in Provider
                    ElevatedButton(
                      onPressed: () => ref.read(counterProvider.notifier).decrement(),
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => ref.read(counterProvider.notifier).increment(),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            // AsyncValue.when() forces you to handle all 3 states explicitly -
            // you cannot forget the error case, unlike a plain FutureBuilder
            // where it's easy to skip snapshot.hasError.
            child: postsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (posts) => ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(posts[index]['title']),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
