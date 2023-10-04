import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../cdn/domain/entity/branch_info.dart';
import '../../../../cdn/presentation/bloc/branch_info_bloc.dart';
import '../../../../drop_down/presentation/widget/m_drop_down_widget.dart';
import '../../../../language/manager/localizatios.dart';
import '../../../../map/presentation/widget/m_map_widget.dart';
import '../../bloc/sign_up_bloc.dart';
import '../../cubit/registration_controller_cubit.dart';
import '../contact_info/contact_info_widget.dart';
import '../finalize/finalize_info_widget.dart';

@RoutePage()
class SuggestedBranchWidget extends StatefulWidget {
  static const path = 'suggested-branch';
  const SuggestedBranchWidget({
    super.key,
    @PathParam.inherit() String? phoneNumber,
  });

  @override
  State<SuggestedBranchWidget> createState() => _SuggestedBranchWidgetState();
}

class _SuggestedBranchWidgetState extends State<SuggestedBranchWidget> {
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
                        const SizedBox(height: 32),
                        _branchInfoWidget,
                        const SizedBox(height: 32),
                        _mapWidget,
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
            Strings.of(context).suggested_branch_title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: Fonts.regular400,
              color: MColors.textColorOf(context),
            ),
          ),
        ),
      );

  Widget get _branchInfoWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.selectedBranch != current.selectedBranch),
        builder: (context, state) =>
            BlocBuilder<BranchInfoBloc, BranchInfoState>(
          builder: (context, bState) => MDropDownWidget<BranchInfo>(
            items: bState.items,
            titleBuilder: (item) => item?.title,
            selectedItem: state.selectedBranch,
            hint: Strings.of(context).selected_branch_hint,
            label: Strings.of(context).selected_branch_label,
            isLoading: bState is BranchInfoLoadingState,
            onItemSelected: context
                .read<RegistrationControllerCubit>()
                .updateSelectedBranch,
            error: () {
              if (!state.showError || !state.invalidSelectedBranch) {
                return null;
              }
              return Strings.of(context).empty_selected_branch_error;
            }(),
          ),
        ),
      );

  Widget get _mapWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            previous.selectedBranch != current.selectedBranch,
        builder: (context, state) => MMapWidget(
          lat: state.selectedBranch?.lat,
          lng: state.selectedBranch?.lng,
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
        builder: (context, state) => BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, sState) => MButtonWidget(
            onClick: _onSuggestedBranchSubmitClick,
            title: Strings.of(context).final_review_and_submit,
            width: UiUtils.maxInputSize,
            isEnable: state.isEnable,
            isLoading: sState is SignUpLoadingState,
          ),
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
    context.navigateNamedTo(ContactInfoWidget.path);
  }

  void _onSuggestedBranchSubmitClick() {
    final state = context.read<RegistrationControllerCubit>().onNextClick();

    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.navigateNamedTo(FinalizeInfoWidget.path);
    // context.read<SignUpBloc>().add(SubmitSignUpEvent(
    //       activityArea: state.getActivityArea,
    //       activityType: state.activityType!,
    //       address: state.address,
    //       balanceSheet: state.balanceSheet!,
    //       boardMemberInfo: state.boardMemberInfo,
    //       ceoInfo: state.ceoInfo,
    //       // city: state.city!,
    //       companyTitle: state.companyTitle,
    //       economicId: state.getEconomicId!,
    //       email: state.email,
    //       mobileNumber: state.mobileNumber,
    //       newspaper: state.newspaper!,
    //       otherDocuments: state.getOtherDocuments,
    //       phoneNumber: state.phoneNumber,
    //       profitAndLossStatement: state.profitAndLossStatement!,
    //       // province: state.province!,
    //       selectedBranch: state.selectedBranch!,
    //       statute: state.statute!,
    //       suggestedComapnies: state.suggestedComapnies,
    //       website: state.website,
    //     ));
  }
}
