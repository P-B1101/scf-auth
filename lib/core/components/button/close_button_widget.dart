import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/assets.dart';

class CloseButtonWidget extends StatelessWidget {
  final Color? color;
  const CloseButtonWidget({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: Navigator.of(context).pop,
          customBorder: const CircleBorder(),
          child: Center(
            child: Transform.rotate(
              angle: .25 * pi,
              child: Icon(
                Fonts.plus,
                color: color ?? MColors.whiteColor,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
