import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/board_members_intro_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/company_intro_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/files_widget.dart';

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
  // final _

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  _title,
                  const SizedBox(height: 67),
                  CompanyIntroWidget(
                    onCompanyIntroEditClick: _onCompanyIntroEditClick,
                  ),
                  const SizedBox(height: 100),
                  BoardMembersIntroWidget(
                    onBoardMembersIntroEditClick: _onBoardMembersIntroEditClick,
                  ),
                  const SizedBox(height: 100),
                  FilesWidget(onFileEditClick: _onFilesEditClick),
                  const SizedBox(height: 100),
                ],
              ),
            ),
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

  void _onCompanyIntroEditClick() {
    //Todo: Complete it later
  }
  void _onBoardMembersIntroEditClick() {
    //Todo: Complete it later
  }
  void _onFilesEditClick() {
    //Todo: Complete it later
  }
}
