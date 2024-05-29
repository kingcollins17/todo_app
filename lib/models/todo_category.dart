import 'todo_item.dart';

class TodoCategoryData {
  final String category;
  final List<TodoItemData> todos;

  const TodoCategoryData({required this.category, required this.todos});

  factory TodoCategoryData.fromJson(json) {
    return TodoCategoryData(
        category: json['category'],
        todos: (json['todos'] as List)
            .map((e) => TodoItemData.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() =>
      {'category': category, 'todos': todos.map((e) => e.toJson()).toList()};

  @override
  String toString() {
    return 'TodoCategory{category: $category, todos: $todos}';
  }
}
