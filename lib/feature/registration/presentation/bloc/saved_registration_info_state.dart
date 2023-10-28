part of 'saved_registration_info_bloc.dart';

sealed class SavedRegistrationInfoState extends Equatable {
  const SavedRegistrationInfoState();

  @override
  List<Object?> get props => [];
}

final class SavedRegistrationInfoInitial extends SavedRegistrationInfoState {}

final class SavedRegistrationInfoLoadingState
    extends SavedRegistrationInfoState {}

final class SavedRegistrationInfoSuccessState
    extends SavedRegistrationInfoState {
  final SignUpRequestBody item;
  const SavedRegistrationInfoSuccessState({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

final class SavedRegistrationInfoFailureState
    extends SavedRegistrationInfoState {
  final String? message;
  const SavedRegistrationInfoFailureState([this.message]);

  @override
  List<Object?> get props => [message];
}

final class SavedRegistrationInfoUnAuthorizeFailureState
    extends SavedRegistrationInfoState {}
