// ignore_for_file: prefer_const_constructors

import 'package:todo_app/models/models.dart';

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

      case TodoActionType.complete when action.payload is TodoItemData:
        (action.payload as TodoItemData).completeTodo();
        state.notification = 'Todo Completed!';
        // Future.delayed(Duration(seconds: 3), () => state.notification = null);
        break;
      //
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
