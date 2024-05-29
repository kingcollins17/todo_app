// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
// import 'router_config.dart';

final theme = ThemeData(
  fontFamily: 'WorkSans',
  colorScheme: ColorScheme.light(),
);

const shade = Color(0xFFF1F1F1),
    primary = Colors.blueAccent,
    eggWhite = Color(0xFFFFEFC6),
    onahau = Color(0xFFC6F8FF),
    paleLavendar = Color(0xFFEADAFF),
    blazeOrange = Color(0xFFFF6C1C),
    scooter = Color(0xFF14C3DB),
    lavendarIndigo = Color(0xFF9057d5);

Size screen(BuildContext context) => MediaQuery.of(context).size;

SizedBox spacer({double x = 5, double y = 5}) => SizedBox(width: x, height: y);

/// available are [home, calendar, favorites, add, more]
///
/// The map holds the path to svg files in the asset folder
const iconsUrl = {
  'addTodo': 'asset/svg/add-kc.svg.txt',
  'calendar': 'asset/svg/calendar-kc.svg.txt',
  'favorites': 'asset/svg/favorites-kc.svg.txt',
  'home': 'asset/svg/home-kc.svg.txt',
  'more': 'asset/svg/more-kc.svg.txt'
};

extension Aligner on Widget {
  Widget align(Alignment value) => Align(alignment: value, child: this);
}
