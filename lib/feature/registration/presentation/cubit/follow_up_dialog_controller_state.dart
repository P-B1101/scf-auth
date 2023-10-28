part of 'follow_up_dialog_controller_cubit.dart';

class FollowUpDialogControllerState extends Equatable {
  final OTPStep step;
  final String phoneNumber;
  final String refrenceCode;
  final String otp;
  final String otpToken;
  final bool showError;
  const FollowUpDialogControllerState({
    required this.otp,
    required this.phoneNumber,
    required this.refrenceCode,
    required this.step,
    required this.otpToken,
    required this.showError,
  });

  @override
  List<Object> get props => [
        otp,
        phoneNumber,
        step,
        showError,
        otpToken,
        refrenceCode,
      ];

  factory FollowUpDialogControllerState.init() =>
      const FollowUpDialogControllerState(
        otp: '',
        phoneNumber: '',
        step: OTPStep.phoneNumber,
        showError: false,
        otpToken: '',
        refrenceCode: '',
      );

  FollowUpDialogControllerState copyWith({
    OTPStep? step,
    String? otp,
    String? phoneNumber,
    String? otpToken,
    String? refrenceCode,
    bool? showError,
  }) =>
      FollowUpDialogControllerState(
        otp: otp ?? this.otp,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        step: step ?? this.step,
        showError: showError ?? this.showError,
        otpToken: otpToken ?? this.otpToken,
        refrenceCode: refrenceCode ?? this.refrenceCode,
      );

  bool get isEnable {
    switch (step) {
      case OTPStep.phoneNumber:
        if (invalidPhoneNumber) return false;
        if (invalidRefrenceCode) return false;
        return true;
      case OTPStep.otp:
        if (invalidOtp) return false;
        return true;
    }
  }

  bool get invalidPhoneNumber {
    if (phoneNumber.isEmpty) return true;
    return !phoneNumber.isValidMobileNumber;
  }

  bool get invalidRefrenceCode => refrenceCode.isEmpty;

  bool get invalidOtp {
    if (otp.isEmpty) return true;
    return !otp.isValidOtp;
  }
}
