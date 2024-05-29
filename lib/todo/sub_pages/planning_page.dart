// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/notification_widget.dart';
import 'package:todo_app/shared.dart';
import 'package:todo_app/store/store.dart';
import '../widgets/widgets.dart';

import '../../models/models.dart';

class TodoPlanningPage extends StatefulWidget {
  const TodoPlanningPage({super.key});

  @override
  State<TodoPlanningPage> createState() => _TodoPlanningPageState();
}

class _TodoPlanningPageState extends State<TodoPlanningPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, TodoViewModel>(
        converter: (store) => TodoViewModel(store),
        builder: (context, vm) {
          return LayoutBuilder(builder: (context, constraints) {
            var headerStyle = TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF303030),
            );
            var dropdown = Transform.rotate(
                angle: math.pi / 2,
                child: Icon(Icons.arrow_forward_ios_outlined,
                    size: 18, color: Color(0xFF616161)));
            //
            return Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Overdue', style: headerStyle),
                            dropdown,
                          ],
                        ),
                        spacer(),
                        ...[
                          TodoItem(
                            data: TodoItemData(todo: 'Shopping'),
                            overDue: true,
                            showDetails: true,
                          ),
                          TodoItem(
                              data: TodoItemData(todo: 'Yoga Class'),
                              overDue: true,
                              showDetails: true),
                        ],
                        ...overdue(vm),
                        spacer(y: 15),
                        spacer(y: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Planning', style: headerStyle),
                            dropdown
                          ],
                        ),
                        spacer(y: 10),
                        ...([...vm.state.todos, ...vm.state.completedTodos]
                            .map((e) => TodoItem(
                                  data: e,
                                  showDetails: true,
                                )))
                        // ...List.generate(
                        //     vm.state.todos.length,
                        //     (index) => TodoItem(
                        //         showDetails: true, data: vm.state.todos[index]))
                      ],
                    ),
                  ),
                  if (vm.state.notification != null)
                    Positioned(
                        top: 8,
                        child: NotificationWidget(
                            notification: vm.state.notification!,
                            closer: () {
                              vm.dispatch(TodoAction(
                                  type: TodoActionType.clearNotification));
                            }))
                ],
              ),
            );
          });
        });
  }

  Iterable<Widget> overdue(TodoViewModel vm) {
    return vm.state.todos
        .where((element) =>
            element.deadline.day < DateTime.now().day &&
            element.deadline.month < DateTime.now().month)
        .toList()
        .map((e) => TodoItem(data: e, overDue: true, showDetails: true));
  }
}
