import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive setup: initialize storage, register the generated adapter for our
  // model, then open a named "box" (Hive's term for a collection/table).
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: TasksPage());
}

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final Box<Task> _box = Hive.box<Task>('tasks');
  final _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isEmpty) return;
    // .add() writes directly to disk - no separate "save" step needed,
    // and no JSON encoding/decoding - Hive stores real Dart objects.
    _box.add(Task(title: _controller.text));
    _controller.clear();
    setState(() {});
  }

  void _toggleTask(Task task) {
    task.isDone = !task.isDone;
    task.save(); // HiveObject gives every stored object a .save() method
    setState(() {});
  }

  void _deleteTask(Task task) {
    task.delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive Tasks')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'New task'),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTask),
              ],
            ),
          ),
          Expanded(
            // ValueListenableBuilder + box.listenable() auto-rebuilds the UI
            // whenever the box's data changes - no manual setState needed
            // for the list itself once this is wired up.
            child: ValueListenableBuilder(
              valueListenable: _box.listenable(),
              builder: (context, Box<Task> box, _) {
                final tasks = box.values.toList();
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (_) => _toggleTask(task),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTask(task),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
