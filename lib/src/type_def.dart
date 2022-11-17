import 'package:flutter/material.dart';

typedef StepperAvatarBuilder<T> = PreferredSize Function(
  BuildContext context,
  T value,
);

typedef StepperWidgetBuilder<T> = PreferredSize Function(
  BuildContext context,
  T value,
);

typedef StepperContentBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);
