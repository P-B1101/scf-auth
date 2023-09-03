import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';
import '../../cubit/registration_controller_cubit.dart';
import '../contact_info/contact_info_widget.dart';
import '../documents_upload/documents_upload_widget.dart';
import 'suggested_company_info_widget.dart';

@RoutePage()
class SuggestedCompanyWidget extends StatefulWidget {
  static const path = 'suggested-company';
  const SuggestedCompanyWidget({
    super.key,
    @PathParam.inherit() String? phoneNumber,
  });

  @override
  State<SuggestedCompanyWidget> createState() => _SuggestedCompanyWidgetState();
}

class _SuggestedCompanyWidgetState extends State<SuggestedCompanyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: UiUtils.maxWidth + 48,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 56),
                        _titleWidget,
                        const SizedBox(height: 64),
                        _inputListWidget,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: _addActivityAreaButtonWidget,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _actionButtonsWidget,
      ],
    );
  }

  Widget get _titleWidget => Builder(
        builder: (context) => SizedBox(
          width: double.infinity,
          child: Text(
            Strings.of(context).suggested_company_title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: Fonts.regular400,
              color: MColors.textColorOf(context),
            ),
          ),
        ),
      );

  Widget get _inputListWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.suggestedComapnies != current.suggestedComapnies),
        builder: (context, state) {
          final items = state.suggestedComapnies;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              items.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SuggestedCompanyInfoWidget(
                  hasDivider: index < items.length - 1 ||
                      state.canAddSuggestedCompanies,
                  economicId: items[index].economicId,
                  financialInteraction: items[index].financialInteraction,
                  name: items[index].name,
                  onEconomicIdChange: (value) => context
                      .read<RegistrationControllerCubit>()
                      .updateSuggestedCompanyEconomicIdAt(index, value),
                  onFinancialInteractionChange: (value) => context
                      .read<RegistrationControllerCubit>()
                      .updateSuggestedCompanyFinancialInteractionAt(
                          index, value),
                  onNameChange: (value) => context
                      .read<RegistrationControllerCubit>()
                      .updateSuggestedCompanyNameAt(index, value),
                  onDeleteClick: index > 0
                      ? () => context
                          .read<RegistrationControllerCubit>()
                          .deleteSuggestedCompany(index)
                      : null,
                  financialInteractionError: () {
                    if (!state.showError ||
                        !state.invalidSuggestedCompaniesFinancialInteraction ||
                        !items[index].invalidFinancialIteraction) {
                      return null;
                    }
                    return Strings.of(context)
                        .empty_suggested_company_financial_interaction_error;
                  }(),
                  nameError: () {
                    if (!state.showError ||
                        !state.invalidSuggestedCompaniesName ||
                        !items[index].invalidName) {
                      return null;
                    }
                    return Strings.of(context)
                        .empty_suggested_company_name_error;
                  }(),
                  economicIdError: () {
                    if (!state.showError ||
                        !state.invalidSuggestedCompaniesEconomicId ||
                        !items[index].invalidEconomicId) {
                      return null;
                    }
                    if (items[index].economicId.isEmpty) {
                      return Strings.of(context)
                          .empty_suggested_company_economic_id_error;
                    }
                    return Strings.of(context)
                        .wrong_suggested_company_economic_id_error;
                  }(),
                ),
              ),
            ),
          );
        },
      );

  Widget get _addActivityAreaButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) => (previous.canAddSuggestedCompanies !=
            current.canAddSuggestedCompanies),
        builder: (context, state) => SizedBox(
          width: UiUtils.maxInputSize,
          child: AnimatedCrossFade(
            duration: UiUtils.duration,
            sizeCurve: UiUtils.curve,
            firstCurve: UiUtils.curve,
            secondCurve: UiUtils.curve,
            crossFadeState: state.canAddSuggestedCompanies
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: MButtonWidget.textWithIcon(
                onClick: _onAddMoreSuggestedCompanyClick,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10,
                    bottom: 10,
                    end: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Fonts.plus,
                          size: 12,
                          color: MColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Strings.of(context).add_more_suggested_company,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: Fonts.regular400,
                          color: MColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            secondChild: const SizedBox(width: UiUtils.maxInputSize),
          ),
        ),
      );

  Widget get _actionButtonsWidget => Builder(
        builder: (context) => Container(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxWidth),
          padding: const EdgeInsets.only(bottom: 56, top: 24),
          child: Wrap(
            spacing: 86,
            runSpacing: 40,
            children: [
              _backButtonWidget,
              _nextButtonWidget,
            ],
          ),
        ),
      );

  Widget get _nextButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) => previous.isEnable != current.isEnable,
        builder: (context, state) => MButtonWidget(
          onClick: _onSuggestedCompanyNextClick,
          title: Strings.of(context).next_step_label,
          width: UiUtils.maxInputSize,
          isEnable: state.isEnable,
        ),
      );

  Widget get _backButtonWidget => Builder(
        builder: (context) => MButtonWidget.outline(
          onClick: _onBackClick,
          title: Strings.of(context).back_step_label,
          width: UiUtils.maxInputSize,
        ),
      );

  void _onBackClick() {
    final state = context.read<RegistrationControllerCubit>().onBackClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.navigateNamedTo(DocumentsUploadWidget.path);
  }

  void _onAddMoreSuggestedCompanyClick() {
    context.read<RegistrationControllerCubit>().addSuggestedCompany();
  }

  void _onSuggestedCompanyNextClick() {
    final state = context.read<RegistrationControllerCubit>().onNextClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.navigateNamedTo(ContactInfoWidget.path);
  }
}
