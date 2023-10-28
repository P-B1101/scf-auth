part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

final class SendOtpEvent extends OtpEvent {
  final String phoneNumber;
  final String? refrenceCode;
  const SendOtpEvent({
    required this.phoneNumber,
    required this.refrenceCode,
  });

  factory SendOtpEvent.registration(String phoneNumber) =>
      SendOtpEvent(phoneNumber: phoneNumber, refrenceCode: null);

  @override
  List<Object?> get props => [phoneNumber, refrenceCode];
}

final class ResendOtpEvent extends OtpEvent {
  final String otpToken;
  final bool isFollowUp;
  const ResendOtpEvent({
    required this.otpToken,
    required this.isFollowUp,
  });

  factory ResendOtpEvent.registration(String otpToken) => ResendOtpEvent(
        otpToken: otpToken,
        isFollowUp: false,
      );

  factory ResendOtpEvent.followUp(String otpToken) => ResendOtpEvent(
        otpToken: otpToken,
        isFollowUp: false,
      );

  @override
  List<Object> get props => [
        otpToken,
        isFollowUp,
      ];
}

final class ValidateOtpEvent extends OtpEvent {
  final String otpToken;
  final String code;
  final bool isFollowUp;

  const ValidateOtpEvent({
    required this.code,
    required this.otpToken,
    required this.isFollowUp,
  });

  factory ValidateOtpEvent.registration({
    required String otpToken,
    required String code,
  }) =>
      ValidateOtpEvent(
        code: code,
        otpToken: otpToken,
        isFollowUp: false,
      );

  factory ValidateOtpEvent.followUp({
    required String otpToken,
    required String code,
  }) =>
      ValidateOtpEvent(
        code: code,
        otpToken: otpToken,
        isFollowUp: true,
      );

  @override
  List<Object> get props => [otpToken, code, isFollowUp];
}
