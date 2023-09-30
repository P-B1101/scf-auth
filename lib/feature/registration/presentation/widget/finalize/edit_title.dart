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
        //Todo: Ask pedram about padding (do we have to change padding? because it seems good already)
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
            ),
            const Spacer(),
            _IconButton(onEditClick: onEditClick)
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key? key,
    required this.onEditClick,
  }) : super(key: key);

  final Function() onEditClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MColors.editTitleColor,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onEditClick,
        child: SizedBox(
          width: size,
          height: size,
          child: const Center(
            child: Icon(
              Fonts.edit,
              size: 21,
              color: MColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  double get size => 32;
}
