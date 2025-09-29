class Task {
  String id;
  String title;
  String description;
  DateTime dateTime;
  int priority;
  String category;
  List<Task> subtasks;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
    required this.category,
    this.subtasks = const [],
  });
}
