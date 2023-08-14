import 'dart:ui';

import 'package:flutter/material.dart';

class BaseDialogWidget extends StatelessWidget {
  final Widget child;
  const BaseDialogWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: Navigator.of(context).pop,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: Colors.black.withOpacity(.3),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: child,
          ),
        ),
      ),
    );
  }
}
