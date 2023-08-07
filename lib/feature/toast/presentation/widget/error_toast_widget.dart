import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class ErrorToastWidget extends StatelessWidget {
  final String message;
  const ErrorToastWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 18, right: 18, top: 4, bottom: 4),
      constraints: const BoxConstraints(minHeight: 56),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: MColors.redColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MColors.primaryDarkTextColor,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Fonts.close,
              size: 16,
              color: MColors.redColor,
            ),
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
