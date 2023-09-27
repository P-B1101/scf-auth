import 'package:flutter/material.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';

class CompanyIntroductionWidget extends StatelessWidget {
  const CompanyIntroductionWidget({
    super.key,
    required this.onCompanyIntroEditClick,
    required this.companyTitleController,
    required this.companyTitleNode,
  });

  final Function() onCompanyIntroEditClick;

  final TextEditingController companyTitleController;
  final FocusNode companyTitleNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(
          title: Strings.of(context).company_introduction,
          onEditClick: onCompanyIntroEditClick,
        ),
        SizedBox(
          width: UiUtils.maxWidth,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              ReadOnlyWidgets(
                title: Strings.of(context).company_title_label,
                //Todo: change it
                hintTxt: 'عنوان رسمی',
                controller: companyTitleController,
                focusNode: companyTitleNode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
