import 'package:flutter/material.dart';

class KeyboardDismissableWidget extends StatelessWidget {
  final Widget child;
  const KeyboardDismissableWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: child,
    );
  }
}
