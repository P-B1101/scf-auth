import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/extensions.dart';
import 'package:scf_auth/feature/dialog/manager/dialog_manager.dart';

import '../../../router/app_router.gr.dart';
import '../widget/landing_toolbar_widget.dart';

@RoutePage()
class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const _LandingPage();
  }
}

class _LandingPage extends StatefulWidget {
  const _LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<_LandingPage> createState() => __LandingPageState();
}

class __LandingPageState extends State<_LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LandingToolbarWidget(
            // onEditRegistrationClick: _onEditRegistrationClick,
            onRequestRegistrationClick: _onRequestRegistrationClick,
            onTrackingClick: _onTrackingClick,
          ),
        ],
      ),
    );
  }

  // void _onEditRegistrationClick() {
  // }

  void _onRequestRegistrationClick() async {
    final phoneNumber =
        await DialogManager.instance.showRegistrationDialog(context);
    if (!mounted) return;
    if (!phoneNumber.isValidMobileNumber) return;
    context.pushRoute(RegistrationRoute(
      phonenumber: phoneNumber,
      followup: 'false',
    ));
  }
  

  void _onTrackingClick() async {
    final result = await DialogManager.instance.showFollowUpDialog(context);
    if (!mounted) return;
    if (!result) return;
    context.pushRoute(RegistrationRoute(followup: 'true'));
  }
}
