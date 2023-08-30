part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

final class SendOtpEvent extends OtpEvent {
  final String phoneNumber;
  const SendOtpEvent({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

final class ValidateOtpEvent extends OtpEvent {
  final String otpToken;
  final String code;

  const ValidateOtpEvent({
    required this.code,
    required this.otpToken,
  });

  @override
  List<Object> get props => [otpToken, code];
}
