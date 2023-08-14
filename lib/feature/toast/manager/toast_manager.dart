import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/enums.dart';
import '../../../core/utils/ui_utils.dart';
import '../../language/manager/localizatios.dart';
import '../presentation/widget/error_toast_widget.dart';
import '../presentation/widget/info_toast_widget.dart';
import '../presentation/widget/success_toast_widget.dart';
import '../presentation/widget/warning_toast_widget.dart';

abstract class ToastManager {
  Future<void> showToast({
    required BuildContext context,
    required String message,
    ToastState state = ToastState.info,
    ToastGravity? gravity,
  });

  Future<void> showFailureToast({
    required BuildContext context,
    required String? message,
    ToastGravity? gravity,
  });

  Future<void> showNoInternetToast(BuildContext context);
}

@LazySingleton(as: ToastManager)
class ToastManagerImpl implements ToastManager {
  final FToast fToast;

  const ToastManagerImpl({
    required this.fToast,
  });

  @override
  Future<void> showToast({
    required BuildContext context,
    required String message,
    ToastState state = ToastState.info,
    ToastGravity? gravity,
  }) async {
    fToast.init(context);
    fToast.removeQueuedCustomToasts();
    final Widget child;
    switch (state) {
      case ToastState.info:
        child = InfoToastWidget(message: message);
        break;
      case ToastState.success:
        child = SuccessToastWidget(message: message);
        break;
      case ToastState.warning:
        child = WarningToastWidget(message: message);
        break;
      case ToastState.error:
        child = ErrorToastWidget(message: message);
        break;
    }
    fToast.showToast(
      child: child,
      gravity: gravity ?? ToastGravity.BOTTOM,
      positionedToastBuilder: (context, child) => PositionedDirectional(
        bottom: 0,
        start: 0,
        child: FadedSlideAnimation(
          beginOffset: const Offset(0, .5),
          endOffset: const Offset(0, 0),
          fadeCurve: Curves.decelerate,
          slideCurve: Curves.decelerate,
          fadeDuration: UiUtils.duration,
          slideDuration: UiUtils.duration,
          child: child,
        ),
      ),
      toastDuration: const Duration(seconds: 10),
    );
  }

  @override
  Future<void> showFailureToast({
    required BuildContext context,
    required String? message,
    ToastGravity? gravity,
  }) =>
      showToast(
        context: context,
        message: message ?? Strings.of(context).general_error,
        state: ToastState.error,
        gravity: gravity,
      );

  @override
  Future<void> showNoInternetToast(BuildContext context) => showToast(
        context: context,
        message: Strings.of(context).internet_error,
        state: ToastState.error,
      );
}
