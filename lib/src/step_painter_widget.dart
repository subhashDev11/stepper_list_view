import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'stepper_theme_data.dart';

class StepPainterWidget extends StatelessWidget {
  const StepPainterWidget({
    required this.stepperAvatar,
    required this.stepperContent,
    required this.isLast,
    required this.stepperWidget,
    super.key,
  });

  final PreferredSizeWidget stepperAvatar;
  final Widget stepperContent;
  final bool isLast;
  final PreferredSizeWidget stepperWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(top: 5, right: 5), child: stepperWidget),
        Expanded(
          child: CustomPaint(
            painter: RootPainter(
              stepperAvatar.preferredSize,
              context.watch<StepperThemeData>().lineColor,
              context.watch<StepperThemeData>().lineWidth,
              Directionality.of(context),
              isLast,
              context.watch<StepperThemeData>().isDashed,
              context.watch<StepperThemeData>().dashLength,
              context.watch<StepperThemeData>().dashGap,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stepperAvatar,
                const SizedBox(width: 4),
                Expanded(child: stepperContent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RootPainter extends CustomPainter {
  RootPainter(
    this.avatar,
    this.pathColor,
    this.strokeWidth,
    this.textDecoration,
    this.isLast,
    this.isDashed,
    this.dashLength,
    this.dashGap,
  ) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  Size? avatar;
  late Paint _paint;
  Color? pathColor;
  double? strokeWidth;
  final TextDirection textDecoration;
  final bool isLast;
  final bool isDashed;
  final double dashLength;
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    if (textDecoration == TextDirection.rtl) {
      canvas.translate(size.width, 0);
    }
    double dx = avatar!.width / 2;
    if (textDecoration == TextDirection.rtl) {
      dx *= -1;
    }
    if (!isLast) {
      final startY = avatar!.height;
      final endY = size.height;

      if (isDashed) {
        _drawDashedLine(canvas, Offset(dx, startY), Offset(dx, endY));
      } else {
        canvas.drawLine(Offset(dx, startY), Offset(dx, endY), _paint);
      }
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end) {
    final totalLength = (end.dy - start.dy).abs();
    final dashPattern = dashLength + dashGap;
    final numberOfDashes = (totalLength / dashPattern).floor();
    final remainder = totalLength % dashPattern;

    double currentY = start.dy;
    final x = start.dx;

    for (int i = 0; i < numberOfDashes; i++) {
      final dashEndY = currentY + dashLength;
      canvas.drawLine(Offset(x, currentY), Offset(x, dashEndY), _paint);
      currentY += dashPattern;
    }

    // Draw remaining dash if any
    if (remainder > 0 && remainder <= dashLength) {
      canvas.drawLine(Offset(x, currentY), Offset(x, currentY + remainder), _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
