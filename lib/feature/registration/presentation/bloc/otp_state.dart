part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];

  bool get isLoading => switch (this) {
        SendOtpLaodingState() || ValidateOtpLaodingState() => true,
        _ => false,
      };
}

final class OtpInitial extends OtpState {}

final class SendOtpLaodingState extends OtpState {}

final class ResendOtpLaodingState extends OtpState {}

final class ValidateOtpLaodingState extends OtpState {}

final class SendOtpSuccessState extends OtpState {
  final String otpToken;
  const SendOtpSuccessState({
    required this.otpToken,
  });

  @override
  List<Object> get props => [otpToken];
}

final class ValidateOtpSuccessState extends OtpState {}

final class OtpFailureState extends OtpState {
  final String? message;
  const OtpFailureState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

final class ValidateOtpUnAuthorizeState extends OtpState {}
