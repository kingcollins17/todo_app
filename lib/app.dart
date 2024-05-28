// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: const Scaffold(
      body: Center(
        child: Text('Todo App'),
      ),
    ));
  }
}
