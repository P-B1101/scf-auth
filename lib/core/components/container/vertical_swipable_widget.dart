import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/enums.dart';

class VerticalSwipableWidget extends StatelessWidget {
  final Widget child;
  final Function(VerticalSwipeAxis) onSwipe;
  final Function()? onTap;
  const VerticalSwipableWidget({
    super.key,
    required this.child,
    required this.onSwipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > _sensitivity) {
          onSwipe(VerticalSwipeAxis.top);
        } else if (details.delta.dy < -_sensitivity) {
          onSwipe(VerticalSwipeAxis.bottom);
        }
      },
      child: child,
    );
  }
}

const _sensitivity = 4.0;
