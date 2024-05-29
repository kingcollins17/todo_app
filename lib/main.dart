// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:todo_app/store/store.dart';

import 'app.dart';

void main() {
  // final persistor = Persistor(storage: , serializer: serializer)
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(StoreProvider(store: createStore(), child: TodoApp())); //entry point
}
