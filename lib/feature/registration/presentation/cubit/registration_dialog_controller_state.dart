part of 'registration_dialog_controller_cubit.dart';

class RegistrationDialogControllerState extends Equatable {
  final OTPStep step;
  final String phoneNumber;
  final String otp;
  final String otpToken;
  final bool showError;
  const RegistrationDialogControllerState({
    required this.otp,
    required this.phoneNumber,
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
      ];

  factory RegistrationDialogControllerState.init() =>
      const RegistrationDialogControllerState(
        otp: '',
        phoneNumber: '',
        step: OTPStep.phoneNumber,
        showError: false,
        otpToken: '',
      );

  RegistrationDialogControllerState copyWith({
    OTPStep? step,
    String? otp,
    String? phoneNumber,
    String? otpToken,
    bool? showError,
  }) =>
      RegistrationDialogControllerState(
        otp: otp ?? this.otp,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        step: step ?? this.step,
        showError: showError ?? this.showError,
        otpToken: otpToken ?? this.otpToken,
      );

  bool get isEnable {
    switch (step) {
      case OTPStep.phoneNumber:
        if (invalidPhoneNumber) return false;
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

  bool get invalidOtp {
    if (otp.isEmpty) return true;
    return !otp.isValidOtp;
  }
}
