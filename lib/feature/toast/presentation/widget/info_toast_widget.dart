import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class InfoToastWidget extends StatelessWidget {
  final String message;
  const InfoToastWidget({
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
        color: MColors.primaryTextColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Fonts.transfer,
            size: 24,
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
