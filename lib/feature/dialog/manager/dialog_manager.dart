import 'package:flutter/material.dart';
import 'package:scf_auth/feature/map/domain/entity/selected_location.dart';
import 'package:scf_auth/feature/registration/presentation/widget/registration_otp_dialog_widget.dart';

import '../../map/presentation/widget/select_location_dialog_widget.dart';
import '../../registration/presentation/widget/follow_up_otp_dialog_widget.dart';
import '../../registration/presentation/widget/success_submit_dialog_widget.dart';

class DialogManager {
  const DialogManager._();

  static const DialogManager _instance = DialogManager._();

  static DialogManager get instance => _instance;

  static bool _showSuccessSubmitDialog = false;
  static bool _showSelectLocationDialog = false;
  static bool _showRegistrationDialog = false;
  static bool _showFollowUpDialog = false;

  Future<void> showSuccessSubmitDialog({
    required BuildContext context,
    required String trackingId,
    required bool hasIban,
  }) async {
    if (_showSuccessSubmitDialog) return;
    _showSuccessSubmitDialog = true;
    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: SuccessSubmitDialogWidget(
          trackingId: trackingId,
          hasIban: hasIban,
        ),
      ),
      barrierColor: Colors.transparent,
    );
    _showSuccessSubmitDialog = false;
  }

  Future<SelectedLocation?> showSelectLocationDialog({
    required BuildContext context,
    double? lat,
    double? lng,
    bool isReadOnly = false,
  }) async {
    if (_showSelectLocationDialog) return null;
    _showSelectLocationDialog = true;
    final result = await showDialog<SelectedLocation>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: SelectLocationDialogWidget(
          lat: lat,
          lng: lng,
          isReadOnly: isReadOnly,
        ),
      ),
      barrierColor: Colors.transparent,
    );
    _showSelectLocationDialog = false;
    return result;
  }

  Future<String> showRegistrationDialog(BuildContext context) async {
    if (_showRegistrationDialog) return '';
    _showRegistrationDialog = true;
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: RegistrationOTPDialogWidget(),
      ),
      barrierColor: Colors.transparent,
    );
    _showRegistrationDialog = false;
    return result ?? '';
  }

  Future<bool> showFollowUpDialog(BuildContext context) async {
    if (_showFollowUpDialog) return false;
    _showFollowUpDialog = true;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: FollowUpOTPDialogWidget(),
      ),
      barrierColor: Colors.transparent,
    );
    _showFollowUpDialog = false;
    return result ?? false;
  }
}
