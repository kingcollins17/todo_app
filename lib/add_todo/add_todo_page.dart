// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/notification_widget.dart';
import 'package:todo_app/router_config.dart';
import 'package:todo_app/shared.dart';
import 'package:todo_app/store/store.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final formKey = GlobalKey<FormState>();
  String? todo, category = categories.last;
  int deadline = 2;
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return StoreConnector<TodoState, TodoViewModel>(
        converter: (store) => TodoViewModel(store),
        builder: (context, vm) {
          return Stack(
            children: [
              Scaffold(
                  appBar: AppBar(
                      title: Text(
                    'Add Todo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'You must enter a Task'
                                          : null,
                                  onChanged: (value) => todo = value,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Todo Task',
                                    isDense: true,
                                  ),
                                ),
                                spacer(y: 15),
                                Text(
                                  'Select category',
                                  style: style,
                                ).align(Alignment.centerLeft),
                                spacer(y: 6),
                                _categories,
                                spacer(y: 15),
                                Text('Deadline in?', style: style)
                                    .align(Alignment.centerLeft),
                                DropdownButtonFormField<int>(
                                  hint: Text('Tap to select deadline'),
                                  validator: (value) => value == null
                                      ? 'Please pick a deadline'
                                      : null,
                                  items: List.generate(
                                      31,
                                      (index) => DropdownMenuItem(
                                            value: index + 1,
                                            child: Text(
                                              '${index + 1} days',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                  onChanged: (value) =>
                                      deadline = value ?? deadline,
                                )
                              ],
                            )),
                        Expanded(
                            child: FilledButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              final item = TodoItemData(
                                todo: todo!,
                                dueIn: Duration(days: deadline),
                                category: category!,
                              );
                              vm.dispatch(
                                TodoAction(
                                    type: TodoActionType.add, payload: item),
                              );
                              Future.delayed(Duration(seconds: 2), () {
                                vm.dispatch(TodoAction(
                                  type: TodoActionType.clearNotification,
                                ));
                                Navigator.of(context)
                                    .pushReplacementNamed(NamedRoute.home.path);
                              });
                            }
                          },
                          child: Text(
                            'Add Todo',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ).align(Alignment.bottomCenter))
                      ],
                    ),
                  )),
              if (vm.state.notification != null)
                Positioned(
                    top: 20,
                    child: NotificationWidget(
                        notification: vm.state.notification!,
                        closer: () {
                          vm.dispatch(TodoAction(
                            type: TodoActionType.clearNotification,
                          ));
                        }))
            ],
          );
        });
  }

  Widget get _categories => Row(
          children: List.generate(
        categories.length,
        (index) => GestureDetector(
          onTap: () => setState(() => category = categories[index]),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: categories[index] == category
                    ? scooter
                    : Color(0xFFCECECE)),
            child: Text(categories[index],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
      ));
}
