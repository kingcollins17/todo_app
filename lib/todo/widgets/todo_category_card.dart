// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/router_config.dart';
import 'package:todo_app/shared.dart';

import 'circular_progress.dart';

class TodoCategoryCard extends StatelessWidget {
  const TodoCategoryCard(
      {super.key,
      required this.cardTitle,
      required this.completed,
      required this.total,
      required this.background,
      required this.progressColor});
  final String cardTitle;
  final int completed, total;
  final Color background, progressColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          width: screen(context).width / 2.4,
          // height: 150,
          margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: background),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              spacer(),
              Text(
                '$completed/$total Completed',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              spacer(y: 20),
              Align(
                alignment: Alignment.center,
                child: CircularProgressBar(
                  fraction: (completed / total),
                  color: progressColor,
                ),
              ),
              spacer(y: 20),
              _addTodoButton(() {
                Navigator.of(context).pushReplacementNamed(
                  NamedRoute.addTodo.path,
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  Widget _addTodoButton(VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
                color: Color(0xCAFFFFFF),
                borderRadius: BorderRadius.circular(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconsUrl['addTodo']!,
                  width: 20,
                  // colorFilter: ColorFilter.mode(Colors.black, BlendMode.src),
                ),
                spacer(),
                Text(
                  'Add Todo',
                  style: TextStyle(fontSize: 14),
                )
              ],
            )),
      );
}
