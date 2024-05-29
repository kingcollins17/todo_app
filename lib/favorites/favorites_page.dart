// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/todo/widgets/todo_item.dart';

import '../store/store.dart' hide createStore;

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Favorites',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
      body: StoreConnector<TodoState, TodoViewModel>(
          builder: (context, vm) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: vm.state.todos
                      .where((element) => element.isFavorite)
                      .toList()
                      .map((e) => TodoItem(data: e))
                      .toList(),
                ),
              ),
          converter: (store) => TodoViewModel(store)),
    );
  }
}
