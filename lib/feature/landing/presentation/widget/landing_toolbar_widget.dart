import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/ui_utils.dart';

import '../../../../core/utils/assets.dart';
import '../../../language/manager/localizatios.dart';

class LandingToolbarWidget extends StatelessWidget {
  final Function() onTrackingClick;
  final Function() onEditRegistrationClick;
  final Function() onRequestRegistrationClick;
  const LandingToolbarWidget({
    super.key,
    required this.onEditRegistrationClick,
    required this.onRequestRegistrationClick,
    required this.onTrackingClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      color: MColors.primaryColor,
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: UiUtils.maxWidth),
        child: Row(
          children: [
            _logoWidget,
            const Expanded(child: SizedBox()),
            _trackingButtonWidget,
            _editRegistrationButtonWidget,
            _requestRegistrationButtonWidget,
          ],
        ),
      ),
    );
  }

  Widget get _logoWidget => Builder(
        builder: (context) => Image.asset(
          'assets/images/png/logo.png',
          fit: BoxFit.contain,
          width: 110,
        ),
      );

  Widget get _trackingButtonWidget => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onTrackingClick,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  Strings.of(context).tracking_registration_label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: Fonts.regular400,
                    color: MColors.featureBoxColorOf(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _editRegistrationButtonWidget => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onEditRegistrationClick,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  Strings.of(context).edit_registration_label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: Fonts.regular400,
                    color: MColors.featureBoxColorOf(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _requestRegistrationButtonWidget => Builder(
        builder: (context) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MColors.featureBoxColorOf(context),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onRequestRegistrationClick,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Fonts.profile,
                      size: 22,
                      color: MColors.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      Strings.of(context).request_registration_label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: Fonts.regular400,
                        color: MColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
