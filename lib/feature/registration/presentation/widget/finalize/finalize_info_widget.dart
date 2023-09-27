import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../language/manager/localizatios.dart';

@RoutePage()
class FinalizeInfoWidget extends StatefulWidget {
  static const path = 'finalize-info';
  const FinalizeInfoWidget({
    super.key,
    @PathParam.inherit() String? phoneNumber,
  });

  @override
  State<FinalizeInfoWidget> createState() => _FinalizeInfoWidgetState();
}

class _FinalizeInfoWidgetState extends State<FinalizeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return const _BodyWidget();
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 48),
              _title,
            ],
          ),
        ),
        //Todo: button
      ],
    );
  }

  Widget get _title => Builder(
        builder: (context) => Text.rich(
          style: const TextStyle(
            fontSize: 20,
            fontWeight: Fonts.regular400,
            color: MColors.primaryTextColor,
          ),
          TextSpan(
            children: [
              TextSpan(text: Strings.of(context).register_your_info),
              TextSpan(
                text: ' ${Strings.of(context).complete}',
                style: const TextStyle(color: MColors.primaryColor),
              ),
              TextSpan(
                text: ' ${Strings.of(context).review_info}',
              ),
              TextSpan(
                text: ' ${Strings.of(context).correction}',
                style: const TextStyle(color: MColors.primaryColor),
              ),
              TextSpan(
                text: ' ${Strings.of(context).verb}',
              ),
            ],
          ),
        ),
      );
}
