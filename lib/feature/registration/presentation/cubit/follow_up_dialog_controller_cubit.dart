import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';

part 'follow_up_dialog_controller_state.dart';

@injectable
class FollowUpDialogControllerCubit
    extends Cubit<FollowUpDialogControllerState> {
  FollowUpDialogControllerCubit() : super(FollowUpDialogControllerState.init());

  void updatePhoneNumber(String phoneNumber) =>
      emit(state.copyWith(phoneNumber: phoneNumber));

  void updateRefrenceCode(String refrenceCode) =>
      emit(state.copyWith(refrenceCode: refrenceCode));

  void updateOTP(String otp) => emit(state.copyWith(otp: otp));

  void updateOTPToken(String otpToken) => emit(state.copyWith(
        otpToken: otpToken,
        step: OTPStep.otp,
      ));

  void clearOTPToken() => emit(state.copyWith(
        otpToken: null,
        step: OTPStep.phoneNumber,
      ));

  FollowUpDialogControllerState? nextClick() {
    if (!state.isEnable) {
      emit(state.copyWith(showError: true));
      return null;
    }
    final newState = state.copyWith(showError: false);
    emit(newState);
    return newState;
  }

  void onBackClick() {
    switch (state.step) {
      case OTPStep.phoneNumber:
        return;
      case OTPStep.otp:
        emit(state.copyWith(
          step: OTPStep.phoneNumber,
          otpToken: '',
        ));
        break;
    }
  }
}
