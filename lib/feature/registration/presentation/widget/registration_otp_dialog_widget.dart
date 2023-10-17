import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:scf_auth/core/components/button/m_button.dart';
import 'package:scf_auth/core/components/input/m_input_widget.dart';
import 'package:scf_auth/core/components/text/input_label_widget.dart';
import 'package:scf_auth/core/utils/enums.dart';
import 'package:scf_auth/core/utils/extensions.dart';
import 'package:scf_auth/feature/language/manager/localizatios.dart';
import 'package:scf_auth/feature/registration/presentation/bloc/otp_bloc.dart';
import 'package:scf_auth/feature/timer/presentation/cubit/timer_controller_cubit.dart';

import '../../../../core/components/button/close_button_widget.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../injectable_container.dart';
import '../../../dialog/presentation/base_dialog_widget.dart';
import '../../../timer/presentation/widget/timer_widget.dart';
import '../../../toast/manager/toast_manager.dart';
import '../cubit/registration_dialog_controller_cubit.dart';

class RegistrationOTPDialogWidget extends StatelessWidget {
  const RegistrationOTPDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationDialogControllerCubit>(
          create: (context) => getIt<RegistrationDialogControllerCubit>(),
        ),
        BlocProvider<OtpBloc>(
          create: (context) => getIt<OtpBloc>(),
        ),
      ],
      child: const _RegistrationOTPDialogWidget(),
    );
  }
}

class _RegistrationOTPDialogWidget extends StatefulWidget {
  const _RegistrationOTPDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_RegistrationOTPDialogWidget> createState() =>
      __RegistrationOTPDialogWidgetState();
}

class __RegistrationOTPDialogWidgetState
    extends State<_RegistrationOTPDialogWidget> {
  final _formatter = MNumberFormatter();
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _phoneNode = FocusNode();
  final _otpNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneNode.requestFocus();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    _phoneNode.dispose();
    _otpNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      child: Container(
        width: UiUtils.maxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            colors: [
              MColors.dialogStartColor,
              MColors.dialogCenterColor,
              MColors.dialogEndColor,
            ],
          ),
        ),
        child: _body,
      ),
    );
  }

  Widget get _body => Builder(
        builder: (context) => MultiBlocListener(
          listeners: [
            BlocListener<OtpBloc, OtpState>(
              listener: (context, state) => _handleOtpState(state),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 8, top: 8),
                  child: CloseButtonWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    _titleWidget,
                    _mainBodyWidget,
                    _buttonWidget,
                    const SizedBox(height: 56),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _titleWidget => BlocBuilder<RegistrationDialogControllerCubit,
          RegistrationDialogControllerState>(
        buildWhen: (previous, current) => previous.step != current.step,
        builder: (context, state) => SizedBox(
          width: double.infinity,
          child: AnimatedSwitcher(
            duration: UiUtils.duration,
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: () {
              return switch (state.step) {
                OTPStep.phoneNumber => Text(
                    Strings.of(context).registration_otp_title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: Fonts.medium500,
                      color: MColors.whiteColor,
                    ),
                  ),
                OTPStep.otp => Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: Text(
                          Strings.of(context)
                              .registration_otp_validate_otp_title
                              .replaceFirst('\$0', _phoneNumberController.text),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: Fonts.medium500,
                            color: MColors.whiteColor,
                          ),
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _onBackClick,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Strings.of(context).edit_phone_number,
                                style: const TextStyle(
                                  color: MColors.whiteColor,
                                  fontSize: 18,
                                  fontWeight: Fonts.medium500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: MColors.whiteColor,
                                  decorationThickness: 4,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const SizedBox.square(
                                dimension: 24,
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Fonts.arrowDown,
                                    size: 18,
                                    color: MColors.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              };
            }(),
          ),
        ),
      );

  Widget get _mainBodyWidget => BlocBuilder<RegistrationDialogControllerCubit,
          RegistrationDialogControllerState>(
        buildWhen: (previous, current) => previous.step != current.step,
        builder: (context, state) => SizedBox(
          width: double.infinity,
          height: 330,
          child: AnimatedSwitcher(
            duration: UiUtils.duration,
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: () {
              switch (state.step) {
                case OTPStep.phoneNumber:
                  return _phoneNumberWidget;
                case OTPStep.otp:
                  return _validateOtpWidget;
              }
            }(),
          ),
        ),
      );

  Widget get _phoneNumberWidget => BlocBuilder<
          RegistrationDialogControllerCubit, RegistrationDialogControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.phoneNumber != current.phoneNumber),
        builder: (context, state) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).company_mobile_label,
                hasError: state.showError && state.invalidPhoneNumber,
                color: MColors.whiteColor,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _phoneNumberController,
                focusNode: _phoneNode,
                textColor: MColors.whiteColor,
                onSubmit: (value) => _onNextClick(),
                borderColor: MColors.inputBorderColorOf(context),
                keyboardType: TextInputType.phone,
                cursorColor: MColors.inputBorderColorOf(context),
                autofillHints: const [AutofillHints.telephoneNumber],
                hint: Strings.of(context).company_mobile_label,
                onTextChange: context
                    .read<RegistrationDialogControllerCubit>()
                    .updatePhoneNumber,
                error: () {
                  if (!state.showError || !state.invalidPhoneNumber) {
                    return null;
                  }
                  if (state.phoneNumber.isEmpty) {
                    return Strings.of(context).empty_mobile_error;
                  }
                  return Strings.of(context).invalid_mobile_error;
                }(),
                maxLength: 13,
                closeKeyboardOnFinish: false,
              ),
            ],
          ),
        ),
      );

  Widget get _validateOtpWidget => BlocBuilder<
          RegistrationDialogControllerCubit, RegistrationDialogControllerState>(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                preFilledWidget: Container(
                  width: 34,
                  height: 1,
                  margin: const EdgeInsets.only(top: 24),
                  color: MColors.inputBorderColorOf(context),
                ),
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 56,
                  textStyle: const TextStyle(
                    fontFamily: Fonts.yekan,
                    color: MColors.whiteColor,
                    fontSize: 14,
                    fontWeight: Fonts.medium500,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: MColors.whiteColor,
                    ),
                  ),
                ),
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,
                animationCurve: UiUtils.curve,
                animationDuration: UiUtils.duration,
                autofillHints: const [AutofillHints.oneTimeCode],
                controller: _otpController,
                focusNode: _otpNode,
                hapticFeedbackType: HapticFeedbackType.mediumImpact,
                keyboardType: TextInputType.phone,
                length: 6,
                forceErrorState: state.showError && state.invalidOtp,
                onChanged: (value) {
                  context
                      .read<RegistrationDialogControllerCubit>()
                      .updateOTP(value.clearFormat);
                  if (value.isValidOtp) _onNextClick();
                },
                inputFormatters: [_formatter],
                followingPinTheme: PinTheme(
                  width: 60,
                  height: 56,
                  textStyle: TextStyle(
                    fontFamily: Fonts.yekan,
                    color: MColors.inputTextColorOf(context),
                    fontSize: 14,
                    fontWeight: Fonts.medium500,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: MColors.inputBorderColorOf(context),
                    ),
                  ),
                ),
                errorPinTheme: PinTheme(
                  width: 60,
                  height: 56,
                  textStyle: const TextStyle(
                    fontFamily: Fonts.yekan,
                    color: MColors.redColor,
                    fontSize: 14,
                    fontWeight: Fonts.medium500,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: MColors.redColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 90),
              child: AnimatedCrossFade(
                duration: UiUtils.duration,
                sizeCurve: Curves.ease,
                firstCurve: Curves.ease,
                secondCurve: Curves.ease,
                crossFadeState: state.showError && state.invalidOtp
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 6),
                  child: Text(
                    () {
                      if (state.otp.isEmpty) {
                        return Strings.of(context).empty_otp_error_message;
                      }
                      if (state.invalidOtp) {
                        return Strings.of(context).wrong_otp_error_message;
                      }
                      return '';
                    }(),
                    style: const TextStyle(
                      fontWeight: Fonts.medium500,
                      fontSize: 12,
                      color: MColors.redColor,
                    ),
                  ),
                ),
                secondChild: const SizedBox(width: double.infinity),
              ),
            ),
            const SizedBox(height: 32),
            _timerWidget,
          ],
        ),
      );

  Widget get _timerWidget => BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) => BlocBuilder<
            RegistrationDialogControllerCubit,
            RegistrationDialogControllerState>(
          builder: (context, rState) => TimerWidget(
            id: rState.otpToken,
            action: MButtonWidget.text(
              padding: const EdgeInsets.symmetric(vertical: 8),
              onClick: _onResendClick,
              title: Strings.of(context).resend_otp_title,
              width: 120,
              isLoading: state is ResendOtpLaodingState,
              color: MColors.whiteColor,
            ),
            builder: (remainTime) => Text(
              Strings.of(context)
                  .timer_place_holder
                  .replaceFirst('\$0', remainTime.toMinuteAndSecond)
                  .toPersianNumber,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: Fonts.medium500,
                color: MColors.whiteColor,
              ),
            ),
          ),
        ),
      );

  Widget get _buttonWidget => BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) => BlocBuilder<
            RegistrationDialogControllerCubit,
            RegistrationDialogControllerState>(
          builder: (context, rState) => MButtonWidget(
            width: UiUtils.maxInputSize,
            onClick: _onNextClick,
            title: Strings.of(context).submit_title,
            isEnable: rState.isEnable,
            isLoading: state.isLoading,
          ),
        ),
      );

  void _onNextClick() {
    final state = context.read<RegistrationDialogControllerCubit>().nextClick();
    if (state == null) return;
    switch (state.step) {
      case OTPStep.phoneNumber:
        context
            .read<OtpBloc>()
            .add(SendOtpEvent(phoneNumber: _phoneNumberController.text));
        break;
      case OTPStep.otp:
        context.read<OtpBloc>().add(ValidateOtpEvent(
              code: _otpController.text.clearFormat,
              otpToken: state.otpToken,
            ));
        break;
    }
  }

  void _onBackClick() {
    context.read<RegistrationDialogControllerCubit>().onBackClick();
  }

  void _onResendClick() {
    final state = context.read<RegistrationDialogControllerCubit>().state;
    context.read<OtpBloc>().add(ResendOtpEvent(otpToken: state.otpToken));
  }

  void _handleOtpState(OtpState state) async {
    if (state is OtpFailureState) {
      getIt<ToastManager>()
          .showFailureToast(context: context, message: state.message);
    } else if (state is SendOtpSuccessState) {
      context
          .read<RegistrationDialogControllerCubit>()
          .updateOTPToken(state.otpToken);
      _otpNode.requestFocus();
      context.read<TimerControllerCubit>().startTimer(state.otpToken);
    } else if (state is ValidateOtpSuccessState) {
      Navigator.of(context).pop(_phoneNumberController.text);
    }
  }
}
