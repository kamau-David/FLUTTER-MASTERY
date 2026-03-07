import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tasks_provider.dart';

// PRESENTATION layer (UI side): only knows about the provider, never
// touches TaskRepository or Hive/Supabase directly. If you were to open
// ONLY this file, you'd have zero idea (and zero need to know) what's
// storing the data underneath.
class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks (Clean Architecture)')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ref.read(tasksProvider.notifier).addTask(controller.text);
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return CheckboxListTile(
                  title: Text(task.title),
                  value: task.isDone,
                  onChanged: (_) => ref.read(tasksProvider.notifier).toggleTask(task),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
