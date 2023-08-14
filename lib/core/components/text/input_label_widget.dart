import 'package:flutter/material.dart';

import '../../utils/assets.dart';
import '../../utils/ui_utils.dart';

class InputLabelWidget extends StatelessWidget {
  final String label;
  final bool hasError;
  const InputLabelWidget(
    this.label, {
    super.key,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: UiUtils.duration,
      curve: UiUtils.curve,
      style: TextStyle(
        fontFamily: Fonts.yekan,
        color: hasError ? MColors.errorColor : MColors.textColorOf(context),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: Fonts.regular400,
        ),
      ),
    );
  }
}
