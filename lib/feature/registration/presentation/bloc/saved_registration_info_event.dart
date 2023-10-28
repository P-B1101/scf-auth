part of 'saved_registration_info_bloc.dart';

sealed class SavedRegistrationInfoEvent extends Equatable {
  const SavedRegistrationInfoEvent();

  @override
  List<Object> get props => [];
}

final class GetSavedRegistrationInfoEvent extends SavedRegistrationInfoEvent {}
