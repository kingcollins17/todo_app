const categories = ['Health', 'Work', 'Personal'];

///
///
class TodoItemData {
  bool isFavorite;

  bool get isCompleted => _dateCompleted != null;
  final String todo;
  final DateTime deadline;
  final String category;

  DateTime? _dateCompleted;

  TodoItemData({
    this.isFavorite = false,
    bool? isCompleted,
    required this.todo,
    this.category = 'Personal',
    Duration? dueIn,
    DateTime? deadline,
  })  : this.deadline =
            deadline ?? DateTime.now().add(dueIn ?? const Duration(days: 2)),
        _dateCompleted = isCompleted == true ? DateTime.now() : null;

  void completeTodo() => _dateCompleted ??= DateTime.now();

  ///This would be removed in production
  set date(DateTime value) => _dateCompleted = value;
  DateTime? get dateCompleted => _dateCompleted;
  factory TodoItemData.fromJson(dynamic json) {
    return TodoItemData(
        isFavorite: json['isFavorite'],
        todo: json['todo'],
        deadline: json['deadline'],
        category: json['category']
        // isCompleted: json['isCompleted'],
        );
  }

  Map<String, dynamic> toJson() => {
        'isFavorite': isFavorite,
        'todo': todo,
        'deadline': deadline,
        'category': category
        // 'isCompleted': isCompleted
      };

  @override
  toString() =>
      'TodoItemData{todo: $todo, favorite: $isFavorite, deadline: $deadline,'
      ' completed: $isCompleted, dateCompleted: $_dateCompleted, category: $category}';
}

const days = 31;

final mock = [
  TodoItemData(todo: 'Check email', category: categories.first),
  TodoItemData(
      todo: 'Gym routine', isFavorite: true, category: categories.first),
  TodoItemData(
      todo: 'Mobile app prototype',
      isCompleted: true,
      category: categories.first),
  TodoItemData(todo: 'Cook dinner', category: categories.first),
  TodoItemData(todo: 'Yoga class', isFavorite: true, category: categories[1]),
  TodoItemData(todo: 'Cleaning', category: categories[1]),
  TodoItemData(
      todo: 'Online shopping', isCompleted: true, category: categories[1]),
  TodoItemData(todo: 'UX Design', category: categories[1]),
  TodoItemData(
      todo: 'Apply for a job', isFavorite: true, category: categories[1]),
  TodoItemData(todo: 'Read article', category: categories.last),
  TodoItemData(todo: 'Check email', isCompleted: true)
    ..date = DateTime.now().subtract(const Duration(days: days)),
  TodoItemData(todo: 'Yoga Class', isCompleted: true)
    ..date = DateTime.now().subtract(const Duration(days: days)),
  TodoItemData(todo: 'Freelance Work', isFavorite: true)
    ..date = DateTime.now().subtract(const Duration(days: days * 2)),
  TodoItemData(
      todo: 'Video editing', isCompleted: true, category: categories[1])
    ..date = DateTime.now().subtract(const Duration(days: days * 2)),
  TodoItemData(
      todo: 'Water plants', isCompleted: true, category: categories.last)
    ..date = DateTime.now().subtract(const Duration(days: days * 2)),
  TodoItemData(todo: 'Dashboard Design', isFavorite: true)
    ..date = DateTime.now().subtract(const Duration(days: days * 3)),
  TodoItemData(todo: 'Shopping')
    ..date = DateTime.now().subtract(const Duration(days: days * 3)),
];
