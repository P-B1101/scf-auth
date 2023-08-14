import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/components/text/input_label_widget.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../cdn/domain/entity/key_value.dart';
import '../../../../cdn/presentation/bloc/key_value_item_bloc.dart';
import '../../../../drop_down/presentation/widget/m_drop_down_widget.dart';
import '../../../../language/manager/localizatios.dart';
import '../../../../router/app_router.gr.dart';
import '../../cubit/registration_controller_cubit.dart';

@RoutePage()
class CompanyIntroductionWidget extends StatefulWidget {
  const CompanyIntroductionWidget({
    super.key,
  });

  @override
  State<CompanyIntroductionWidget> createState() =>
      _CompanyIntroductionWidgetState();
}

class _CompanyIntroductionWidgetState extends State<CompanyIntroductionWidget> {
  final _titleController = TextEditingController();
  final _economicIdController = TextEditingController();
  final _titleFocusNode = FocusScopeNode();
  final _economicFocusNode = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _economicIdController.dispose();
    _economicFocusNode.dispose();
    _titleFocusNode.dispose();

    super.dispose();
  }

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 56),
                        _titleWidget,
                        const SizedBox(height: 64),
                        _inputListWidget,
                        _addActivityAreaButtonWidget,
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
            Strings.of(context).company_introduction_title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: Fonts.regular400,
              color: MColors.textColorOf(context),
            ),
          ),
        ),
      );

  Widget get _inputListWidget => Builder(
        builder: (context) => Wrap(
          spacing: 86,
          runSpacing: 40,
          children: [
            _companyTitleInput,
            _economicIdInput,
            _activityAreaListWidget,
          ],
        ),
      );

  Widget get _companyTitleInput =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.invalidCompanyTitle && previous.showError) !=
            (current.invalidCompanyTitle && current.showError),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).company_title_label,
                hasError: state.showError && state.invalidCompanyTitle,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _titleController,
                focusNode: _titleFocusNode,
                nextFocusNode: _economicFocusNode,
                autofillHints: const [AutofillHints.organizationName],
                hint: Strings.of(context).company_title_hint,
                onTextChange: context
                    .read<RegistrationControllerCubit>()
                    .updateCompanyTitle,
                error: () {
                  if (!state.showError || !state.invalidCompanyTitle) {
                    return null;
                  }
                  return Strings.of(context).empty_company_title_error;
                }(),
              ),
            ],
          ),
        ),
      );

  Widget get _economicIdInput =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.invalidEconomicId && previous.showError) !=
            (current.invalidEconomicId && current.showError),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).economic_id_label,
                hasError: state.showError && state.invalidEconomicId,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _economicIdController,
                focusNode: _economicFocusNode,
                hint: Strings.of(context).economic_id_hint,
                onTextChange: context
                    .read<RegistrationControllerCubit>()
                    .updateEconomicId,
                error: () {
                  if (!state.showError || !state.invalidEconomicId) {
                    return null;
                  }
                  return Strings.of(context).empty_economic_id_error;
                }(),
              ),
            ],
          ),
        ),
      );

  Widget get _activityAreaListWidget =>
      BlocBuilder<ActivityAreaBloc, KeyValueItemState>(
        builder: (context, kState) => BlocBuilder<RegistrationControllerCubit,
            RegistrationControllerState>(
          buildWhen: (previous, current) =>
              (previous.activityArea != current.activityArea) ||
              (previous.showError != current.showError) ||
              (previous.activityType != current.activityType),
          builder: (context, state) {
            final items = state.activityArea;
            final length = items.length + 1;
            final areaItems = kState.items;
            return Wrap(
              spacing: 86,
              runSpacing: 24,
              children: List.generate(length, (index) {
                final i = index > 1 ? index - 1 : index;
                if (index == 1) {
                  return BlocBuilder<ActivityTypeBloc, KeyValueItemState>(
                    builder: (context, aState) => MDropDownWidget<KeyValue>(
                      items: aState.items,
                      titleBuilder: (item) => item?.title,
                      selectedItem: state.activityType,
                      hint: Strings.of(context).activity_type_hint,
                      label: Strings.of(context).activity_type_label,
                      isLoading: aState is KeyValueItemLoadingState,
                      onItemSelected: context
                          .read<RegistrationControllerCubit>()
                          .updateActivityType,
                      error: () {
                        if (!state.showError || !state.invalidActivityType) {
                          return null;
                        }
                        return Strings.of(context).empty_activity_type_error;
                      }(),
                    ),
                  );
                }
                return MDropDownWidget<KeyValue>(
                  items: areaItems,
                  enableBuilder: (item) =>
                      !items.hasItemWithId(item?.id) ||
                      item?.id == areaItems[i].id,
                  titleBuilder: (item) => item?.title,
                  selectedItem: items[i],
                  hint: Strings.of(context).activity_area_hint,
                  label:
                      '${Strings.of(context).activity_area_label} ${(i + 1).toStringValue(context)}',
                  isLoading: kState is KeyValueItemLoadingState,
                  onItemSelected: (item) => context
                      .read<RegistrationControllerCubit>()
                      .updateActivityAreaAt(item: item, index: i),
                  error: () {
                    if (!state.showError ||
                        !state.invalidActivityArea ||
                        items[i] != null) {
                      return null;
                    }
                    return Strings.of(context).empty_activity_area_error;
                  }(),
                  onDeleteFieldClick: i > 0
                      ? () => context
                          .read<RegistrationControllerCubit>()
                          .deleteActivityArea(i)
                      : null,
                );
              }),
            );
          },
        ),
      );

  Widget get _addActivityAreaButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.canAddMoreArea != current.canAddMoreArea) ||
            (previous.activityArea != current.activityArea),
        builder: (context, state) =>
            BlocBuilder<ActivityAreaBloc, KeyValueItemState>(
          builder: (context, kState) {
            final areaItems = kState.items.filterWith(state.activityArea);
            final canAddMoreArea = state.canAddMoreArea &&
                state.activityArea.length < kState.items.length;
            return SizedBox(
              width: UiUtils.maxInputSize,
              child: AnimatedCrossFade(
                duration: UiUtils.duration,
                sizeCurve: UiUtils.curve,
                firstCurve: UiUtils.curve,
                secondCurve: UiUtils.curve,
                crossFadeState: canAddMoreArea && areaItems.isNotEmpty
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: MButtonWidget.textWithIcon(
                    onClick: _onAddMoreAreaClick,
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
                            Strings.of(context).add_more_activity_area,
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
            );
          },
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
          onClick: _onCompanyIntroductionNextClick,
          title: Strings.of(context).next_step_label,
          width: UiUtils.maxInputSize,
          isEnable: state.isEnable,
        ),
      );

  Widget get _backButtonWidget => Builder(
        builder: (context) => MButtonWidget.outline(
          onClick: _onBackClick,
          title: Strings.of(context).back_to_main_page,
          width: UiUtils.maxInputSize,
        ),
      );

  void _onBackClick() {
    context.replaceRoute(const LandingRoute());
  }

  void _onAddMoreAreaClick() {
    context.read<RegistrationControllerCubit>().addActivityArea();
  }

  void _onCompanyIntroductionNextClick() {
    final state = context.read<RegistrationControllerCubit>().onNextClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.replaceRoute(const ManagementIntroductionRoute());
  }
}
