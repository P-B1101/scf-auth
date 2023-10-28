part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpSuccessState extends SignUpState {
  final SignUpResponse response;
  final bool hasIban;
  const SignUpSuccessState({
    required this.response,
    required this.hasIban,
  });

  @override
  List<Object?> get props => [
        response,
        hasIban,
      ];
}

final class SignUpFailureState extends SignUpState {
  final String? message;
  const SignUpFailureState([this.message]);

  @override
  List<Object?> get props => [message];
}

final class SignUpUnAuthorizeFailureState extends SignUpState {}
