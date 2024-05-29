// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'router_config.dart';

import 'shared.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  NamedRoute currentRoute = NamedRoute.home;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  Widget icon(NamedRoute route, String url) => Container(
        width: screen(context).width / 5.2,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              url,
              color: route == currentRoute ? lavendarIndigo : null,
            ),
            spacer(x: 2),
            Text(
              route.tag,
              style: TextStyle(
                  color: route == currentRoute ? lavendarIndigo : null,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    const navBarHeight = 65.0;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        themeMode: ThemeMode.light,
        home: SafeArea(
          child: Scaffold(
            body: Navigator(
              key: navigatorKey,
              onGenerateRoute: createGenerator(
                  (url) => Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          currentRoute = NamedRoute.equals(url);
                        });
                      })),
            ),
            bottomNavigationBar: NavigationBar(
                height: navBarHeight,
                backgroundColor: Colors.white,
                elevation: 0.0,
                destinations: [
                  ...NamedRoute.values
                      .map((route) => GestureDetector(
                          onTap: () {
                            navigatorKey.currentState
                                ?.pushReplacementNamed(route.path);
                          },
                          child: icon(route, iconsUrl[route.name]!)))
                      .toList()
                ]),
          ),
        ));
  }
}
