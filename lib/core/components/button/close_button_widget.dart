import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/assets.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

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
              child: const Icon(
                Fonts.plus,
                color: MColors.featureBoxColor,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
