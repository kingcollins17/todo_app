// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/shared.dart';
import 'package:todo_app/store/store.dart';
import '../../models/models.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.data,
      this.showDetails = false,
      this.overDue = false});
  final TodoItemData data;
  final bool showDetails;
  final bool overDue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen(context).width * 0.95,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                blurRadius: 2, offset: Offset(1, 3), color: Color(0x14000000))
          ]),
      child: StoreConnector<TodoState, TodoViewModel>(
          converter: (store) => TodoViewModel(store),
          builder: (context, vm) {
            return GestureDetector(
              onTap: () {
                if (data.isCompleted) {
                  vm.dispatch(
                    TodoAction(type: TodoActionType.restore, payload: data),
                  );
                } else {
                  vm.dispatch(
                    TodoAction(type: TodoActionType.complete, payload: data),
                  );
                }
                Future.delayed(
                    Duration(seconds: 2),
                    () => vm.dispatch(
                          TodoAction(type: TodoActionType.clearNotification),
                        ));
              },
              child: Row(
                  crossAxisAlignment: showDetails
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    spacer(x: 8),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          color:
                              data.isCompleted ? scooter : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color:
                                data.isCompleted ? scooter : Color(0xFF636363),
                          )),
                      child: data.isCompleted
                          ? FittedBox(
                              child: Icon(Icons.check, color: Colors.white))
                          : null,
                    ),
                    spacer(x: 15),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: showDetails
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        Text(data.todo,
                            style: TextStyle(
                              decoration: data.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                        if (showDetails) ...[
                          spacer(y: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.calendar_month,
                                  size: 10, color: Color(0xFF707070)),
                              spacer(x: 10),
                              Text(
                                _parseDate(data.deadline),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: overDue ? red : null,
                                    fontWeight:
                                        overDue ? FontWeight.bold : null),
                              ),
                              spacer(x: 10),
                              Icon(Icons.flag,
                                  color: urgency(data.deadline), size: 12)
                            ],
                          )
                        ]
                      ],
                    ),
                    spacer(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => vm.dispatch(
                            TodoAction(
                                type: TodoActionType.favorite, payload: data),
                          ),
                          child: Icon(
                                  data.isFavorite
                                      ? Icons.star
                                      : Icons.star_border_outlined,
                                  color: data.isFavorite
                                      ? Color(0xFFFFCB3B)
                                      : Color(0xFF646464))
                              .align(Alignment.centerRight),
                        ),
                      ),
                    )
                  ]),
            );
          }),
    );
  }
}

const green = Color(0xFF0FD64B);
const yellow = Color(0xFFFFF23B);
const red = Colors.red;
String _parseDate(DateTime date) => '${date.day}.${date.month}.${date.year}';

Color urgency(DateTime date) =>
    switch (date.difference(DateTime.now()).inDays) {
      >= 3 => green,
      > 0 && <= 2 => yellow,
      <= 0 => red,
      _ => Colors.red
    };
