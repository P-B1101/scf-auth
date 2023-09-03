import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        ...PointerDeviceKind.values,
      };
}
