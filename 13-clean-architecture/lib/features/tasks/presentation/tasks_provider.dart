import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/task_repository.dart';
import '../domain/task.dart';

// PRESENTATION layer (state side): this provider depends on the ABSTRACT
// TaskRepository, never a concrete one directly - a technique called
// dependency inversion. Tests can override this provider with a fake
// repository with zero changes to the UI code.
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return InMemoryTaskRepository(); // swap this line to change storage backend
});

class TasksNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;
  TasksNotifier(this._repository) : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = await _repository.getTasks();
  }

  Future<void> addTask(String title) async {
    final task = Task(id: DateTime.now().toIso8601String(), title: title);
    await _repository.addTask(task);
    state = await _repository.getTasks();
  }

  Future<void> toggleTask(Task task) async {
    await _repository.updateTask(task.copyWith(isDone: !task.isDone));
    state = await _repository.getTasks();
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TasksNotifier(repository);
});
