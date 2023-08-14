import 'package:flutter/material.dart';

import '../../registration/presentation/widget/success_submit_dialog_widget.dart';

class DialogManager {
  const DialogManager._();

  static const DialogManager _instance = DialogManager._();

  static DialogManager get instance => _instance;

  static bool _showSuccessSubmitDialog = false;

  Future<void> showSuccessSubmitDialog({
    required BuildContext context,
    required String trackingId,
  }) async {
    if (_showSuccessSubmitDialog) return;
    _showSuccessSubmitDialog = true;
    await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: SuccessSubmitDialogWidget(trackingId: trackingId),
      ),
      barrierColor: Colors.transparent,
    );
    _showSuccessSubmitDialog = false;
  }
}
