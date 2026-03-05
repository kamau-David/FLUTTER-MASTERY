import '../domain/task.dart';

// DATA layer: this is the ONLY place that knows HOW tasks are actually
// stored. The abstract class defines WHAT operations are possible; a
// concrete implementation (Hive, Supabase, in-memory for tests) defines HOW.
abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
}

// A simple in-memory implementation - swap this for HiveTaskRepository or
// SupabaseTaskRepository later WITHOUT changing anything in presentation/,
// because they all depend on the abstract TaskRepository, not this class directly.
class InMemoryTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  Future<List<Task>> getTasks() async => List.unmodifiable(_tasks);

  @override
  Future<void> addTask(Task task) async => _tasks.add(task);

  @override
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _tasks[index] = task;
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
  }
}
