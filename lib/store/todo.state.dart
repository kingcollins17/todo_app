import 'package:flutter/material.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/todo/sub_pages/complete_todos_page.dart';

class TodoState {
  List<TodoItemData> todos = mock;
  List<TodoItemData> completedTodos = mockData;
  String? notification;
  TodoState();
  factory TodoState.initial() => TodoState();

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is TodoState && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;
  @override
  String toString() {
    return "TodoState {todos: $todos}";
  }
}
