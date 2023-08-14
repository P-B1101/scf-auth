import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/assets.dart';

class WarningWidget extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final Widget child;
  final TextStyle? style;
  const WarningWidget({
    super.key,
    required this.startColor,
    required this.endColor,
    this.style,
    required this.child,
  });

  @override
  State<WarningWidget> createState() => _WarningWidgetState();
}

class _WarningWidgetState extends State<WarningWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final color = ColorTween(begin: widget.startColor, end: widget.endColor)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.linear))
            .value;
        return DefaultTextStyle(
          style: (widget.style ?? const TextStyle()).copyWith(
            fontFamily: Fonts.yekan,
            color: color,
          ),
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
