import 'package:flutter/material.dart';
import 'package:scf_auth/feature/map/domain/entity/selected_location.dart';

import '../../map/presentation/widget/select_location_dialog_widget.dart';
import '../../registration/presentation/widget/success_submit_dialog_widget.dart';

class DialogManager {
  const DialogManager._();

  static const DialogManager _instance = DialogManager._();

  static DialogManager get instance => _instance;

  static bool _showSuccessSubmitDialog = false;
  static bool _showSelectLocationDialog = false;

  Future<void> showSuccessSubmitDialog({
    required BuildContext context,
    required String trackingId,
  }) async {
    if (_showSuccessSubmitDialog) return;
    _showSuccessSubmitDialog = true;
    await showDialog<void>(
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

  Future<SelectedLocation?> showSelectLocationDialog({
    required BuildContext context,
    double? lat,
    double? lng,
  }) async {
    if (_showSelectLocationDialog) return null;
    _showSelectLocationDialog = true;
    final result = await showDialog<SelectedLocation>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: SelectLocationDialogWidget(lat: lat, lng: lng),
      ),
      barrierColor: Colors.transparent,
    );
    _showSelectLocationDialog = false;
    return result;
  }
}
