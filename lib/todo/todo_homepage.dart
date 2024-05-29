// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_app/shared.dart';

import 'sub_pages/sub_pages.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  var currentTab = _Tabs.todo;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: shade,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [searchBar, tabBar],
            ),
          ),
          spacer(y: 15),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) => Future.delayed(
                Duration(milliseconds: 600),
                () => setState(() => currentTab = _Tabs.values[value]),
              ),
              children: [
                TodoListPage(),
                TodoPlanningPage(),
                CompletedTodosPage()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget wrapBar(Text child, _Tabs tab) {
    return GestureDetector(
      onTap: () {
        controller.animateToPage(
          tab.index,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        decoration: BoxDecoration(
            border: tab == currentTab
                ? Border(bottom: BorderSide(color: primary, width: 2))
                : null),
        child: child,
      ),
    );
  }

  Widget get tabBar {
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          wrapBar(Text('Todo', style: style), _Tabs.todo),
          wrapBar(Text('Planning', style: style), _Tabs.planning),
          wrapBar(Text('Done', style: style), _Tabs.done),
        ],
      ),
    );
  }

  Widget _child() {
    return SizedBox.expand();
  }

  Widget get searchBar {
    const height = 50.0;
    var circular = BorderRadius.circular(10);
    return Row(children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Container(
          height: 40,
          decoration: BoxDecoration(color: shade, borderRadius: circular),
          child: TextField(
              decoration: InputDecoration(
                  hintText: 'Todo, Task, Plan',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon:
                      Icon(Icons.search, size: 25, color: Color(0xFF8D8D8D)),
                  border: OutlineInputBorder(
                      borderRadius: circular,
                      borderSide: BorderSide(color: Color(0xFF686868))),
                  isDense: true)),
        ),
      )),
      spacer(),
      // Icon(Icons.person, color: Colors.black),
      Container(
        width: 45,
        height: 45,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            shape: BoxShape.circle,
            // color: Color(0xFFD8D8D8),
            image:
                DecorationImage(image: AssetImage('asset/images/profile.jpg'))),
      ),
      spacer(x: 10)
    ]);
  }
}

enum _Tabs { todo, planning, done }
