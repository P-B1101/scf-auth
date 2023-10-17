import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/use_case/resend_otp.dart' as r;
import '../../domain/use_case/send_otp.dart' as s;
import '../../domain/use_case/validate_otp.dart';

part 'otp_event.dart';
part 'otp_state.dart';

@injectable
class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final s.SendOtp _sendOtp;
  final ValidateOtp _validateOtp;
  final r.ResendOtp _resendOtp;
  OtpBloc(this._sendOtp, this._validateOtp, this._resendOtp)
      : super(OtpInitial()) {
    on<SendOtpEvent>(_onSendOtpEvent, transformer: droppable());
    on<ValidateOtpEvent>(_onValidateOtpEvent, transformer: droppable());
    on<ResendOtpEvent>(_onResendOtpEvent, transformer: droppable());
  }

  Future<void> _onSendOtpEvent(
    SendOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(SendOtpLaodingState());
    final result = await _sendOtp(s.Params(phoneNumber: event.phoneNumber));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (otpToken) async => SendOtpSuccessState(otpToken: otpToken),
    );
    emit(newState);
  }

  Future<void> _onResendOtpEvent(
    ResendOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(ResendOtpLaodingState());
    final result = await _resendOtp(r.Params(otpToken: event.otpToken));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (otpToken) async => SendOtpSuccessState(otpToken: otpToken),
    );
    emit(newState);
  }

  Future<void> _onValidateOtpEvent(
    ValidateOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(ValidateOtpLaodingState());
    final result = await _validateOtp(Params(
      code: event.code,
      otpToken: event.otpToken,
    ));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => ValidateOtpSuccessState(),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  OtpState get toState => switch (this) {
        ServerFailure(message: String? message) =>
          OtpFailureState(message: message),
        _ => const OtpFailureState(),
      };
}
