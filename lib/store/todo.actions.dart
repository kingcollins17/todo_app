///A todo action
class TodoAction {
  final TodoActionType type;
  final Object? payload;

  TodoAction({required this.type, this.payload});
}

enum TodoActionType {
  add,
  favorite,
  delete,
  complete,
  // removeFavorite,
  notify,
  clearNotification
}
