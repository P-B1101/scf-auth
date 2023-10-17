import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/enums.dart';

class UiUtils {
  const UiUtils._();

  static const duration = Duration(milliseconds: 300);

  static const curve = Curves.ease;

  static const maxInputSize = 320.0;

  static const maxWidth = 726.0;

  static const dropDownMaxHeight = 350.0;

  static const mapSize = 400.0;
}

class Utils {
  const Utils._();

  static const maxFileSizeAllowed = 10 * 1024 * 1024;
  static const allowedExtensions = ['zip', 'pdf', 'jpeg', 'png'];

  static TargetPlatformType get targetPlatformType {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return kIsWeb
            ? TargetPlatformType.androidPwa
            : TargetPlatformType.androidNative;
      case TargetPlatform.iOS:
        return kIsWeb
            ? TargetPlatformType.iosPwa
            : TargetPlatformType.iosNative;
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        return TargetPlatformType.other;
    }
  }
  
  static Duration timerDuration = const Duration(seconds: 180);
}
