part of 'select_and_upload_bloc.dart';

sealed class SelectAndUploadEvent extends Equatable {
  const SelectAndUploadEvent();

  @override
  List<Object> get props => [];
}

class StartSelectAndUploadEvent extends SelectAndUploadEvent {
  final String title;

  const StartSelectAndUploadEvent({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}
