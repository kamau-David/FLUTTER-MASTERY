// DOMAIN layer: the core business model. Deliberately has ZERO imports from
// Flutter, Hive, or any specific database/API. This means the same Task
// class works whether you're using Hive, Supabase, or a REST API underneath -
// swapping the data layer never touches this file.
class Task {
  final String id;
  final String title;
  final bool isDone;

  const Task({required this.id, required this.title, this.isDone = false});

  Task copyWith({String? title, bool? isDone}) {
    return Task(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
