import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/extensions.dart';
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/edit_title.dart';
import 'package:scf_auth/feature/registration/presentation/widget/finalize/read_only_widgets.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';

class SuggestedCompaniesWidget extends StatelessWidget {
  const SuggestedCompaniesWidget({
    super.key,
    required this.onSuggestedCompanyEditClick,
  });

  final Function() onSuggestedCompanyEditClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditTitle(
          title: Strings.of(context).registration_steps_suggested_company,
          onEditClick: onSuggestedCompanyEditClick,
        ),
        const SizedBox(height: 68),
        SizedBox(
          width: UiUtils.maxWidth,
          child: BlocBuilder<RegistrationControllerCubit,
              RegistrationControllerState>(
            builder: (context, state) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 45,
                    bottom: 24,
                  ),
                  child: Divider(
                    color: MColors.primaryColor,
                  ),
                ),
                itemCount: state.suggestedCompanies.length,
                itemBuilder: (context, index) {
                  final company = state.suggestedCompanies[index];
                  return Wrap(
                    runSpacing: 40,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ReadOnlyWidgets(
                        label: Strings.of(context).suggested_company_name_label,
                        hintTxt:
                            Strings.of(context).suggested_company_name_label,
                        value: company.name,
                      ),
                      ReadOnlyWidgets(
                        label: Strings.of(context).company_economic_id,
                        hintTxt: Strings.of(context).company_economic_id,
                        value: company.economicId,
                      ),
                      ReadOnlyWidgets(
                        label: Strings.of(context)
                            .suggested_company_financial_interaction_label,
                        hintTxt: Strings.of(context)
                            .suggested_company_financial_interaction_label,
                        value: company.financialInteraction?.toCurrency,
                        isCurrency: true,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
