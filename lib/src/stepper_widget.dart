import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stepper_list_view.dart';

class StepperWidget<R, C> extends StatefulWidget {
  const StepperWidget(
    this.root, {
    this.stepperThemeData,
    required this.stepperAvatarBuilder,
    required this.stepperContentBuilder,
    required this.isLast,
    super.key,
    required this.stepperWidgetBuilder,
  });

  final R root;

  final StepperAvatarBuilder<R> stepperAvatarBuilder;
  final StepperContentBuilder<R> stepperContentBuilder;
  final StepperWidgetBuilder<R> stepperWidgetBuilder;

  final StepperThemeData? stepperThemeData;
  final bool isLast;

  @override
  StepperWidgetState<R, C> createState() => StepperWidgetState<R, C>();
}

class StepperWidgetState<R, C> extends State<StepperWidget<R, C>> {
  @override
  Widget build(BuildContext context) {
    final PreferredSize stepperAvatar = widget.stepperAvatarBuilder(
      context,
      widget.root,
    );

    final PreferredSize stepperWidget = widget.stepperWidgetBuilder(
      context,
      widget.root,
    );

    return Provider<StepperThemeData>.value(
      value: widget.stepperThemeData ?? const StepperThemeData(lineWidth: 1),
      child: StepPainterWidget(
        stepperAvatar: stepperAvatar,
        stepperContent: widget.stepperContentBuilder(
          context,
          widget.root,
        ),
        isLast: widget.isLast,
        stepperWidget: stepperWidget,
      ),
    );
  }
}
