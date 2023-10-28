import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';
import '../../cubit/registration_controller_cubit.dart';
import '../company_introduction/company_introduction_widget.dart';
import '../documents_upload/documents_upload_widget.dart';
import 'name_national_code_field.dart';

@RoutePage()
class ManagementIntroductionWidget extends StatefulWidget {
  static const path = 'management-introduction';
  const ManagementIntroductionWidget({
    super.key,
    @PathParam.inherit() String? phoneNumber,
  });

  @override
  State<ManagementIntroductionWidget> createState() =>
      _ManagementIntroductionWidgetState();
}

class _ManagementIntroductionWidgetState
    extends State<ManagementIntroductionWidget> {
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
            Strings.of(context).management_introduction_title,
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
              _ceoWidget,
              _boardMemberListWidget,
            ],
          ),
        ),
      );

  Widget get _ceoWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.ceoInfo != current.ceoInfo) ||
            previous.showError != current.showError,
        builder: (context, state) => NameNationalCodeFieldWidget(
          hasDivider: true,
          requestFocus: true,
          birthDate: state.ceoInfo.birthDate,
          birthDateHint: Strings.of(context).ceo_birth_date_hint,
          birthDateLabel: Strings.of(context).ceo_birth_date_label,
          onNameChange:
              context.read<RegistrationControllerCubit>().updateCeoName,
          onNationalCodeChange:
              context.read<RegistrationControllerCubit>().updateCeoNationalCode,
          onBirthDateChange:
              context.read<RegistrationControllerCubit>().updateCeoBirthDate,
          name: state.ceoInfo.name,
          nationalCode: state.ceoInfo.nationalCode,
          nameHint: Strings.of(context).ceo_name_hint,
          nameLabel: Strings.of(context).ceo_name_label,
          nationalCodeHint: Strings.of(context).ceo_national_code_hint,
          nationalCodeLabel: Strings.of(context).ceo_national_code_label,
          nameError: () {
            if (!state.showError || !state.invalidCeoName) {
              return null;
            }
            return Strings.of(context).empty_ceo_name_error;
          }(),
          nationalCodeError: () {
            if (!state.showError || !state.invalidCeoNationalCode) {
              return null;
            }
            if (state.emptyCeoNationalCode) {
              return Strings.of(context).empty_ceo_national_code_error;
            }
            return Strings.of(context).wrong_ceo_national_code_error;
          }(),
          birthDateError: () {
            if (!state.showError || !state.invalidCeoBirthDate) {
              return null;
            }
            return Strings.of(context).empty_ceo_birth_date_error;
          }(),
        ),
      );

  Widget get _boardMemberListWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.boardMemberInfo != current.boardMemberInfo) ||
            previous.showError != current.showError,
        builder: (context, state) {
          final items = state.boardMemberInfo;
          return Wrap(
            spacing: 86,
            runSpacing: 24,
            children: List.generate(
                items.length,
                (index) => NameNationalCodeFieldWidget(
                      hasDivider: index < items.length - 1 ||
                          state.canAddMoreBoardMember,
                      onBirthDateChange: (birthDate) => context
                          .read<RegistrationControllerCubit>()
                          .updateBoardMemberBirthDateAt(index, birthDate),
                      onNameChange: (name) => context
                          .read<RegistrationControllerCubit>()
                          .updateBoardMemberNameAt(index, name),
                      onNationalCodeChange: (nationalCode) => context
                          .read<RegistrationControllerCubit>()
                          .updateBoardMemberNationalCodeAt(index, nationalCode),
                      birthDate: items[index].birthDate,
                      name: items[index].name,
                      nationalCode: items[index].nationalCode,
                      nameHint: Strings.of(context).board_member_name_hint,
                      nameLabel:
                          '${Strings.of(context).board_member_name_label} ${(index + 1).toStringValue(context)}',
                      nationalCodeHint:
                          Strings.of(context).board_member_national_code_hint,
                      nationalCodeLabel:
                          '${Strings.of(context).board_member_national_code_label} ${(index + 1).toStringValue(context)}',
                      birthDateHint:
                          Strings.of(context).board_member_birth_date_hint,
                      birthDateLabel:
                          '${Strings.of(context).board_member_birth_date_label} ${(index + 1).toStringValue(context)}',
                      nameError: () {
                        if (!state.showError ||
                            !state.invalidBoardMemberName ||
                            !items[index].invalidName) {
                          return null;
                        }
                        return Strings.of(context)
                            .empty_board_member_name_error;
                      }(),
                      nationalCodeError: () {
                        if (!state.showError ||
                            !state.invalidBoardMemberNationalCode ||
                            !items[index].invalidNationalCode) {
                          return null;
                        }
                        if (state.emptyBoardMemberNationalCodeAt(index)) {
                          return Strings.of(context)
                              .empty_board_member_national_code_error;
                        }
                        return Strings.of(context)
                            .wrong_board_member_national_code_error;
                      }(),
                      birthDateError: () {
                        if (!state.showError ||
                            !state.invalidBoardMemberBirthDate ||
                            !items[index].invalidBirthDate) {
                          return null;
                        }
                        return Strings.of(context)
                            .empty_board_member_birth_date_error;
                      }(),
                      onDeleteFieldClick: index > 0
                          ? () => context
                              .read<RegistrationControllerCubit>()
                              .deleteBoardMemberInfo(index)
                          : null,
                    )),
          );
        },
      );

  Widget get _addActivityAreaButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.canAddMoreBoardMember != current.canAddMoreBoardMember) ||
            (previous.boardMemberInfo != current.boardMemberInfo),
        builder: (context, state) => SizedBox(
          width: UiUtils.maxInputSize,
          child: AnimatedCrossFade(
            duration: UiUtils.duration,
            sizeCurve: UiUtils.curve,
            firstCurve: UiUtils.curve,
            secondCurve: UiUtils.curve,
            crossFadeState: state.canAddMoreBoardMember
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: MButtonWidget.textWithIcon(
                onClick: _onAddMoreBoardMemberClick,
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
                        Strings.of(context).add_more_board_member,
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
          onClick: _onManagementIntroductionNextClick,
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
    context.navigateNamedTo(CompanyIntroductionWidget.path);
  }

  void _onAddMoreBoardMemberClick() {
    context.read<RegistrationControllerCubit>().addBoardMemberInfo();
  }

  void _onManagementIntroductionNextClick() {
    final state = context.read<RegistrationControllerCubit>().onNextClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.navigateNamedTo(DocumentsUploadWidget.path);
  }
}
