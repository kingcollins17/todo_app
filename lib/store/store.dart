import 'package:redux/redux.dart';
import 'todo.state.dart';
import 'todo.reducer.dart';

export 'todo.actions.dart';
export 'todo.state.dart';

Store<TodoState> createStore() {
  return Store<TodoState>(todoReducer, initialState: TodoState.initial());
}

class TodoViewModel {
  final Store<TodoState> _store;
  TodoViewModel(this._store);

  TodoState get state => _store.state;

  void dispatch(action) => _store.dispatch(action);
}
