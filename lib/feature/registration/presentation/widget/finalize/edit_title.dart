import 'package:flutter/material.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/ui_utils.dart';

class EditTitle extends StatelessWidget {
  const EditTitle({
    super.key,
    required this.title,
    required this.onEditClick,
  });

  final String title;
  final Function() onEditClick;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: UiUtils.maxWidth,
        height: 36,
        color: MColors.editTitleColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.5),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: Fonts.regular400,
                  color: MColors.primaryColor,
                ),
              )
            ],
          ),
        ));
  }
}
