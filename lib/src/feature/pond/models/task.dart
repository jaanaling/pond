class Task {
  final String id;
  final String title;
  final DateTime dueDate;
  final bool isCompleted;
  final bool isPeriodic;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
    this.isPeriodic = false,
  });
}
