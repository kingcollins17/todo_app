// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_app/shared.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {super.key, required this.notification, required this.closer});
  final String notification;
  final void Function() closer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screen(context).width,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          width: screen(context).width * 0.9,
          decoration: BoxDecoration(
              color: eggWhite,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(1, 3),
                    color: Color(0x13000000))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notification,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(Icons.close, color: Color(0xFF3B3B3B))
            ],
          ),
        ),
      ),
    );
  }
}
