import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class RegistrationToolbarWidget extends StatelessWidget {
  const RegistrationToolbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      color: MColors.primaryColor,
      alignment: Alignment.center,
      child: _logoWidget,
    );
  }

  Widget get _logoWidget => Builder(
        builder: (context) => Image.asset(
          'assets/images/png/logo.png',
          fit: BoxFit.contain,
          width: 110,
        ),
      );
}
