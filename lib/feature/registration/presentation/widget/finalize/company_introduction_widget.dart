import 'package:flutter/material.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';

import '../../../../language/manager/localizatios.dart';

class CompanyIntroductionWidget extends StatelessWidget {
  const CompanyIntroductionWidget({
    super.key,
    required this.onCompanyIntroEditClick,
  });

  final Function() onCompanyIntroEditClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(
            title: Strings.of(context).company_introduction,
            onEditClick: onCompanyIntroEditClick)
      ],
    );
  }
}
