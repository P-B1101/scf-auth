part of 'select_and_upload_bloc.dart';

sealed class SelectAndUploadEvent extends Equatable {
  const SelectAndUploadEvent();

  @override
  List<Object> get props => [];
}

class StartSelectAndUploadEvent extends SelectAndUploadEvent {
  final String title;
  final bool isMultiSelect;
  final UploadFileType type;

  const StartSelectAndUploadEvent({
    required this.title,
    required this.type,
    this.isMultiSelect = false,
  });

  @override
  List<Object> get props => [title, isMultiSelect, type];
}
