// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/notification_widget.dart';
import 'package:todo_app/router_config.dart';
import 'package:todo_app/shared.dart';
import 'package:todo_app/store/store.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final formKey = GlobalKey<FormState>();
  String? todo, category = categories.last;
  DateTime? deadline;
  bool _selectDate = false;

  final today = DateTime.now();

  // bool get selectDate => _selectDate;

  set selectDate(bool value) {
    setState(() => _selectDate = value);
  }

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    return StoreConnector<TodoState, TodoViewModel>(
        converter: (store) => TodoViewModel(store),
        builder: (context, vm) {
          return Stack(
            children: [
              Scaffold(
                  appBar: AppBar(
                      title: Text(
                    'Add Todo',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B3B3B)),
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
                                    labelText: 'Add Task',
                                    isDense: true,
                                  ),
                                ),
                                spacer(y: 25),
                                Text(
                                  'Select category',
                                  style: style,
                                ).align(Alignment.centerLeft),
                                spacer(y: 6),
                                _categories,
                                spacer(y: 25),
                                Text('Deadline', style: style)
                                    .align(Alignment.centerLeft),
                                spacer(y: 12),
                                GestureDetector(
                                  onTap: () => selectDate = true,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: lavendarIndigo),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      parse(deadline) ?? 'Pick a deadline',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            child: FilledButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              final item = TodoItemData(
                                todo: todo!,
                                deadline: deadline!,
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
                        })),
              if (_selectDate) Center(child: _datePicker())
              //   Positioned(child:
              //   ,)
            ],
          );
        });
  }

  String? parse(DateTime? date) {
    if (date == null) return null;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'April',
      'May',
      'Jun',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  Widget _datePicker() {
    return Container(
      width: screen(context).width * 0.9,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 3, offset: Offset(1, 3), color: Color(0x1F000000))
      ]),
      child: CalendarDatePicker(
        currentDate: deadline ?? today,
        initialDate: deadline ?? today,
        firstDate: today,
        lastDate: today.add(Duration(days: 365)),
        onDateChanged: (value) {
          deadline = value;
          selectDate = false;
        },
      ),
    );
  }

  Widget get _categories => Row(
          children: List.generate(
        categories.length,
        (index) => GestureDetector(
          onTap: () => setState(() => category = categories[index]),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: categories[index] == category
                    ? lavendarIndigo
                    : Color(0xFFE4E4E4)),
            child: Text(categories[index],
                style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color:
                        categories[index] == category ? Colors.white : null)),
          ),
        ),
      ));
}
