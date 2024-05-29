// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/add_todo/add_todo_page.dart';
import 'package:todo_app/favorites/favorites_page.dart';
import 'package:todo_app/todo/todo_homepage.dart';

const homeRoute = '/',
    favoritesRoute = '/favorites',
    addToDoRoute = '/add-todo',
    calendarRoute = '/calendar',
    moreRoute = '/more';

enum NamedRoute {
  home('Home', homeRoute),
  favorites('Favorites', favoritesRoute),
  addTodo('Add Todo', addToDoRoute),
  calendar('Calendar', calendarRoute),
  more('More', moreRoute);

  final String tag, path;
  const NamedRoute(this.tag, this.path);

  static NamedRoute equals(String? url) => switch (url) {
        homeRoute => NamedRoute.home,
        favoritesRoute => NamedRoute.favorites,
        addToDoRoute => NamedRoute.addTodo,
        calendarRoute => NamedRoute.calendar,
        moreRoute => NamedRoute.more,
        _ => NamedRoute.home
      };
}

typedef RouteGenerator = MaterialPageRoute Function(RouteSettings settings);

RouteGenerator createGenerator(void Function(String?)? onPushRoute) {
  return (RouteSettings settings) {
    Widget page = switch (settings.name) {
      homeRoute => TodoHomePage(),
      favoritesRoute => FavoritesPage(),
      addToDoRoute => AddTodoPage(),
      _ => Center(child: Text('Unknown Route')),
    };
    if (onPushRoute != null) onPushRoute(settings.name);
    return MaterialPageRoute(builder: (context) => page);
  };
}

class TodoNavigatorObserver extends NavigatorObserver {
  final void Function(Route route)? onPushRoute;

  TodoNavigatorObserver({required this.onPushRoute});

  @override
  void didPush(Route route, Route? previousRoute) {
    if (onPushRoute != null) onPushRoute!(route);
  }
}
