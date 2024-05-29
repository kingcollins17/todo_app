// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CircularProgressBar extends StatefulWidget {
  const CircularProgressBar(
      {super.key, required this.fraction, this.width = 60, required this.color})
      : assert(fraction <= 1.0 && fraction >= 0,
            'Fraction cannot be greater than 1 and less than 0');
  final double fraction;
  final double width;
  final Color color;
  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar> {
  @override
  Widget build(BuildContext context) {
    var strokeWidth = 7.0;
    return SizedBox.square(
      dimension: widget.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            strokeWidth: strokeWidth,
            value: 1,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
          CircularProgressIndicator(
            strokeWidth: strokeWidth,
            value: widget.fraction,
            valueColor: AlwaysStoppedAnimation(widget.color),
          ),
          Center(
            child: Text(
              '${(widget.fraction * 100).toStringAsFixed(1)}%',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
