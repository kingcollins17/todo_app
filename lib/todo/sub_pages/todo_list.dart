// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/notification_widget.dart';
import 'package:todo_app/shared.dart';
import 'package:todo_app/store/store.dart';
import 'package:todo_app/todo/widgets/todo_category_card.dart';

import '../widgets/widgets.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, TodoViewModel>(
        converter: (store) => TodoViewModel(store),
        builder: (context, vm) {
          return LayoutBuilder(builder: (context, constraints) {
            return Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                      height: constraints.maxHeight,
                      width: screen(context).width,
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        child: Column(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight * 0.5,
                              ),
                              child: categoryCards(vm),
                            ),
                            spacer(y: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('All To do',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF303030),
                                    )).align(Alignment.centerLeft),
                                Transform.rotate(
                                  angle: math.pi / 2,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                    color: Color(0xFF363636),
                                  ),
                                )
                              ],
                            ),
                            spacer(y: 15),
                            todoList(vm)
                          ],
                        ),
                      )),
                  if (vm.state.notification != null)
                    Positioned(
                        // top: 10,
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

  final colors = [
    (eggWhite, blazeOrange),
    (onahau, scooter),
    (paleLavendar, lavendarIndigo)
  ];
  Widget categoryCards(TodoViewModel vm) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(categories.length, (index) {
          final items = vm.state.todos
              .where((element) => element.category == categories[index])
              .toList();
          return TodoCategoryCard(
            cardTitle: categories[index],
            completed: items.where((element) => element.isCompleted).length,
            total: items.length,
            background: colors[index].$1,
            progressColor: colors[index].$2,
          );
          // return Text('${items.length}');
        }));
  }

  Widget todoList(TodoViewModel vm) {
    final items =
        vm.state.todos.where((element) => !element.isCompleted).toList();
    return Column(
      children: List.generate(
        items.length,
        (index) => TodoItem(showDetails: false, data: items[index]),
      ),
    );
  }
}
