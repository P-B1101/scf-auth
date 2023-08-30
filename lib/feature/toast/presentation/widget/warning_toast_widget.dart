import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class WarningToastWidget extends StatelessWidget {
  final String message;
  final Function()? onRetry;
  const WarningToastWidget({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 14, bottom: 14),
      color: MColors.secondryColor,
      child: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: Fonts.medium500,
          color: MColors.whiteColor,
        ),
      ),
    );
  }
}
