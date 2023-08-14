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
import '../../../../router/app_router.gr.dart';
import '../../cubit/registration_controller_cubit.dart';

@RoutePage()
class SuggestedBranchWidget extends StatefulWidget {
  const SuggestedBranchWidget({super.key});

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
        builder: (context, state) => MButtonWidget(
          onClick: _onSuggestedBranchSubmitClick,
          title: Strings.of(context).submit_info,
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
    context.replaceRoute(const ContactInfoRoute());
  }

  void _onSuggestedBranchSubmitClick() {
    final state = context.read<RegistrationControllerCubit>().onNextClick();
    if (state == null) return;
    // TODO: submit info.
  }
}
