import 'package:flutter/material.dart';
import 'package:scf_auth/core/components/button/close_button_widget.dart';
import 'package:scf_auth/core/utils/assets.dart';
import 'package:scf_auth/core/utils/ui_utils.dart';
import 'package:scf_auth/feature/language/manager/localizatios.dart';

import '../../../dialog/presentation/base_dialog_widget.dart';

class SuccessSubmitDialogWidget extends StatelessWidget {
  final String trackingId;
  const SuccessSubmitDialogWidget({
    super.key,
    required this.trackingId,
  });
  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      child: Container(
        width: UiUtils.maxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            colors: [
              MColors.dialogStartColor,
              MColors.dialogCenterColor,
              MColors.dialogEndColor,
            ],
          ),
        ),
        child: _body,
      ),
    );
  }

  Widget get _body => Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 8, top: 8),
                child: CloseButtonWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _successIconWidget,
                  const SizedBox(height: 28),
                  _firstTitleWidget,
                  const SizedBox(height: 48),
                  _secondTitleWidget,
                  const SizedBox(height: 42),
                  _thirdTitleWidget,
                  const SizedBox(height: 56),
                  _trackingIdWidget,
                  const SizedBox(height: 56),
                ],
              ),
            ),
          ],
        ),
      );

  Widget get _successIconWidget => Builder(
        builder: (context) => Container(
          width: 57,
          height: 57,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: MColors.successGreenColor,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Fonts.tick,
            size: 30,
            color: MColors.featureBoxColor,
          ),
        ),
      );

  Widget get _firstTitleWidget => Builder(
        builder: (context) => Text(
          Strings.of(context).success_dialog_first_title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: Fonts.bold700,
            color: MColors.successGreenColor,
          ),
        ),
      );

  Widget get _secondTitleWidget => Builder(
        builder: (context) => Text(
          Strings.of(context).success_dialog_second_title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: Fonts.bold700,
            color: MColors.featureBoxColor,
          ),
        ),
      );

  Widget get _thirdTitleWidget => Builder(
        builder: (context) => Text(
          Strings.of(context).success_dialog_third_title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: Fonts.regular400,
            color: MColors.featureBoxColor,
            height: 2.5,
          ),
        ),
      );

  Widget get _trackingIdWidget => Builder(
        builder: (context) => Text(
          Strings.of(context)
              .tracking_id_place_holder
              .replaceFirst('\$0', trackingId),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: Fonts.medium500,
            color: MColors.featureBoxColor,
          ),
        ),
      );
}
