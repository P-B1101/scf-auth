import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/enums.dart';
import 'package:scf_auth/feature/registration/presentation/bloc/saved_registration_info_bloc.dart';

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
import '../management_introduction/management_introduction_widget.dart';

@RoutePage()
class CompanyIntroductionWidget extends StatefulWidget {
  static const path = 'company-introduction';
  const CompanyIntroductionWidget({
    super.key,
    @PathParam.inherit() String? phoneNumber,
  });

  @override
  State<CompanyIntroductionWidget> createState() =>
      _CompanyIntroductionWidgetState();
}

class _CompanyIntroductionWidgetState extends State<CompanyIntroductionWidget> {
  final _titleController = TextEditingController();
  final _economicIdController = TextEditingController();
  final _ibanController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _economicFocusNode = FocusNode();
  final _ibanFocusNode = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _economicIdController.dispose();
    _economicFocusNode.dispose();
    _titleFocusNode.dispose();
    _ibanController.dispose();
    _ibanFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final state = context.read<RegistrationControllerCubit>().state;
    _titleController.text = state.companyTitle;
    _economicIdController.text = state.economicId;
    _ibanController.text = state.iban;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _titleFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SavedRegistrationInfoBloc, SavedRegistrationInfoState>(
          listener: (context, state) =>
              _handleSavedRegistrationInfoState(state),
        ),
      ],
      child: Column(
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
      ),
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
        builder: (context) => FocusTraversalGroup(
          child: Wrap(
            spacing: 86,
            runSpacing: 40,
            children: [
              _companyTitleInput,
              _economicIdInput,
              _ibanWidget,
              _activityAreaListWidget,
            ],
          ),
        ),
      );

  Widget get _companyTitleInput =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.invalidCompanyTitle != current.invalidCompanyTitle) ||
            (previous.showError != current.showError),
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
                textInputAction: TextInputAction.next,
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
            (previous.showError != current.showError) ||
            (previous.economicId != current.economicId),
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
                nextFocusNode: _ibanFocusNode,
                hint: Strings.of(context).economic_id_hint,
                onTextChange: context
                    .read<RegistrationControllerCubit>()
                    .updateEconomicId,
                error: () {
                  if (!state.showError || !state.invalidEconomicId) {
                    return null;
                  }
                  if (state.economicId.isEmpty) {
                    return Strings.of(context).empty_economic_id_error;
                  }
                  return Strings.of(context).wrong_economic_id_error;
                }(),
              ),
            ],
          ),
        ),
      );

  Widget get _ibanWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.iban != current.iban),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).iban_label,
                hasError: state.showError && state.invalidIban,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _ibanController,
                focusNode: _ibanFocusNode,
                hint: Strings.of(context).iban_hint,
                suffixWidget: const Padding(
                  padding: EdgeInsetsDirectional.only(end: 10),
                  child: Text('IR'),
                ),
                onTextChange:
                    context.read<RegistrationControllerCubit>().updateIban,
                error: () {
                  if (!state.showError || !state.invalidIban) {
                    return null;
                  }
                  return Strings.of(context).wrong_iban_error;
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
                  return MDropDownWidget<ActivityType>(
                    items: ActivityType.values,
                    titleBuilder: (item) => item?.toStringValue(context),
                    selectedItem: state.activityType,
                    hint: Strings.of(context).activity_type_hint,
                    label: Strings.of(context).activity_type_label,
                    onItemSelected: context
                        .read<RegistrationControllerCubit>()
                        .updateActivityType,
                    error: () {
                      if (!state.showError || !state.invalidActivityType) {
                        return null;
                      }
                      return Strings.of(context).empty_activity_type_error;
                    }(),
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

  void _handleSavedRegistrationInfoState(
    SavedRegistrationInfoState state,
  ) async {
    if (state is SavedRegistrationInfoSuccessState) {
      _titleController.text = state.item.businessUnitFullName;
      _economicIdController.text = state.item.nationalId;
    }
  }

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
    context.navigateNamedTo(ManagementIntroductionWidget.path);
  }
}
