// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/shared.dart';
import 'package:todo_app/store/store.dart';

import '../../models/models.dart';
import '../widgets/widgets.dart';

class CompletedTodosPage extends StatefulWidget {
  const CompletedTodosPage({super.key});

  @override
  State<CompletedTodosPage> createState() => _CompletedTodosPageState();
}

class _CompletedTodosPageState extends State<CompletedTodosPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<TodoState, TodoViewModel>(
        converter: (store) => TodoViewModel(store),
        builder: (context, vm) {
          return LayoutBuilder(
            builder: (context, constraints) => Material(
              color: Colors.transparent,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                child: Builder(builder: (context) {
                  final histories = historify(vm.state.completedTodos);
                  final children = histories.map((e) => history(e.$1, e.$2));
                  return Column(
                    children: children
                        .map((value) => Column(children: value))
                        .toList(),
                  );
                }),
              ),
            ),
          );
        });
  }

  List<Widget> history(DateTime date, List<TodoItemData> todos) {
    return [
      spacer(),
      Text(
        '${month(date.month)} ${date.year}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).align(Alignment.centerLeft),
      spacer(y: 15),
      ...todos.map((e) => TodoItem(data: e)).toList(),
      spacer(y: 15)
    ];
  }
}

String month(int index) => [
      'Jan',
      'Feb',
      'Mar',
      'April',
      'May',
      'June',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ][index - 1];

List<(DateTime, List<TodoItemData>)> historify(List<TodoItemData> todos) {
  if (todos.isEmpty) return [];
  final result = <DateTime, List<TodoItemData>>{};

  var current = todos.first.dateCompleted!;
  result[current] = <TodoItemData>[todos.first];
  var tempBuffer = <TodoItemData>[];

  for (var i = 1; i < todos.length; i++) {
    // final tempDate = todos[i].dateCompleted!;
    result[current]?.add(todos[i]);

    // if (tempDate.month != current.month && tempDate.year != current.year) {
    //   current = tempDate;
    //   tempBuffer = result[current] ?? []; //get associated list
    //   tempBuffer.add(todos[i]); //add to the list
    //   result[current] = tempBuffer; //store back the list

    // } else {
    //   //if they are of the same month
    //    //simply add to the associated list
    // }
  }

  final res = <(DateTime, List<TodoItemData>)>[];
  for (var MapEntry(:key, :value) in result.entries) {
    res.add((key, value));
  }
  return res;
}

const days = 32;
final mockData = [
  // TodoItemData(todo: 'Check email')
  //   ..date = DateTime.now().subtract(Duration(days: days)),
  TodoItemData(todo: 'Yoga Class')
    ..date = DateTime.now().subtract(Duration(days: days)),
  TodoItemData(todo: 'Freelance Work', isFavorite: true)
    ..date = DateTime.now().subtract(Duration(days: days * 2)),
  // TodoItemData(todo: 'Video editing')
  //   ..date = DateTime.now().subtract(Duration(days: days * 2)),
  TodoItemData(todo: 'Water plants')
    ..date = DateTime.now().subtract(Duration(days: days * 2)),
  // TodoItemData(todo: 'Dashboard Design', isFavorite: true)
  //   ..date = DateTime.now().subtract(Duration(days: days * 3)),
  TodoItemData(todo: 'Shopping')
    ..date = DateTime.now().subtract(Duration(days: days * 3)),
];
