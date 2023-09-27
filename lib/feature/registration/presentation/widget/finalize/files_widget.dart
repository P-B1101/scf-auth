import 'package:flutter/material.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';

import '../../../../language/manager/localizatios.dart';

class FilesWidget extends StatelessWidget {
  const FilesWidget({
    super.key,
    required this.onEditClick,
  });

  final Function() onEditClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(title: Strings.of(context).files, onEditClick: onEditClick)
      ],
    );
  }
}
