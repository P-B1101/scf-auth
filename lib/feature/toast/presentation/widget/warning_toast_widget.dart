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
      width: double.infinity,
      padding: const EdgeInsets.only(left: 18, right: 18, top: 4, bottom: 4),
      constraints: const BoxConstraints(minHeight: 56),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: MColors.secondryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_rounded,
            size: 34,
            color: MColors.primaryDarkTextColor,
          ),
          const SizedBox(width: 18.0),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: Fonts.regular400,
                color: MColors.primaryDarkTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
