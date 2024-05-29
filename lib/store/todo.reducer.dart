// ignore_for_file: prefer_const_constructors

import 'package:todo_app/models/models.dart';
import 'package:todo_app/todo/widgets/todo_item.dart';

import './todo.state.dart';
import './todo.actions.dart';

TodoState todoReducer(TodoState state, action) {
  // TodoState newState = state;
  if (action is TodoAction) {
    switch (action.type) {
      case TodoActionType.add when action.payload is TodoItemData:
        // state.todos.add(action.payload as TodoItemData);
        state.todos = [action.payload as TodoItemData, ...state.todos];
        state.notification = 'Your Todo has been added!';
        break;

      case TodoActionType.delete when action.payload is TodoItemData:
        state.todos.remove(action.payload as TodoItemData);
        break;

      case TodoActionType.favorite when action.payload is TodoItemData:
        var payload = action.payload as TodoItemData;
        (payload).isFavorite = !payload.isFavorite;
        break;

      case TodoActionType.complete
          when action.payload is TodoItemData &&
              !state.completedTodos.contains(action.payload):
        var payload = (action.payload as TodoItemData);
        payload.completeTodo();
        state.notification = 'Todo Completed!';
        state.todos.remove(action.payload);
        state.completedTodos = {payload, ...state.completedTodos}.toList();
        break;

      case TodoActionType.restore
          when action.payload is TodoItemData &&
              state.completedTodos.contains(action.payload):
        final payload = (action.payload as TodoItemData);
        payload.date = null;
        state.notification = 'Task undone';
        state.completedTodos.remove(payload);
        state.todos = {payload, ...state.todos}.toList();
        break;

      case TodoActionType.notify when action.payload is String:
        state.notification = action.payload.toString();
        break;
      case TodoActionType.clearNotification:
        state.notification = null;
        break;
      default:
        break;
    }
  }
  return state;
}
