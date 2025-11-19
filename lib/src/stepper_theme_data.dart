import 'package:flutter/material.dart';

class StepperThemeData {
  const StepperThemeData({
    this.lineColor = Colors.grey,
    this.lineWidth = 2,
    this.isDashed = false,
    this.dashLength = 5.0,
    this.dashGap = 3.0,
  });

  final Color lineColor;
  final double lineWidth;
  final bool isDashed;
  final double dashLength;
  final double dashGap;
}
