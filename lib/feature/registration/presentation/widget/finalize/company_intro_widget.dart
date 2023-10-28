import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/extensions.dart';
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';

class CompanyIntroWidget extends StatelessWidget {
  const CompanyIntroWidget({
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
          onEditClick: onCompanyIntroEditClick,
        ),
        const SizedBox(height: 68),
        SizedBox(
          width: UiUtils.maxWidth,
          child: BlocBuilder<RegistrationControllerCubit,
              RegistrationControllerState>(
            builder: (context, state) {
              return Wrap(
                runSpacing: 40,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  //عنوان رسمی بنگاه اقتصادی
                  ReadOnlyWidgets(
                    label: Strings.of(context).company_title_label,
                    hintTxt: Strings.of(context).official_title,
                    value: state.companyTitle,
                  ),
                  //شناسه اقتصادی
                  ReadOnlyWidgets(
                    label: Strings.of(context).economic_id_label,
                    hintTxt: Strings.of(context).economic_id_label,
                    value: state.economicId,
                  ),
                  ReadOnlyWidgets(
                    label: Strings.of(context).iban_label,
                    hintTxt: Strings.of(context).iban_label,
                    value: state.iban.isEmpty
                        ? Strings.of(context).not_entered
                        : state.iban,
                  ),
                  //نوع فعالیت
                  ReadOnlyWidgets(
                    label: Strings.of(context).activity_type_label,
                    hintTxt: Strings.of(context).activity_type_label,
                    value: state.activityType?.toStringValue(context),
                  ),
                  //حوزه فعالیت
                  ...List.generate(
                    state.activityArea.length,
                    (index) => ReadOnlyWidgets(
                      label:
                          "${Strings.of(context).activity_area_label} ${(index + 1).toStringValue(context)}",
                      hintTxt: Strings.of(context).activity_area_label,
                      value: state.activityArea[index]?.title ?? '',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
