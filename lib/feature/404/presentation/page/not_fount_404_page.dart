import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import '../../../language/manager/localizatios.dart';

class NotFound404Page extends StatelessWidget {
  final bool withScaffold;
  const NotFound404Page({
    super.key,
    this.withScaffold = true,
  });

  @override
  Widget build(BuildContext context) {
    return withScaffold ? Scaffold(body: _childWidget) : _childWidget;
  }

  Widget get _childWidget => Builder(
        builder: (context) => Center(
          child: Text(
            Strings.of(context).not_found_message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: MColors.textColorOf(context),
            ),
          ),
        ),
      );
}
