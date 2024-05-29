import 'package:flutter/material.dart';
import 'package:todo_app/models/models.dart';

class TodoState {
  List<TodoItemData> todos = mock;
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
