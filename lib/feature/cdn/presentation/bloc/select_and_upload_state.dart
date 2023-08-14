part of 'select_and_upload_bloc.dart';

sealed class SelectAndUploadState extends Equatable {
  const SelectAndUploadState();

  @override
  List<Object?> get props => [];
}

final class SelectAndUploadInitial extends SelectAndUploadState {}

final class SelectAndUploadLoadingState extends SelectAndUploadState {}

final class SelectAndUploadSuccessState extends SelectAndUploadState {
  final UploadFileResult result;
  const SelectAndUploadSuccessState({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

final class SelectAndUploadFileSizeFailureState extends SelectAndUploadState {
  final int size;
  const SelectAndUploadFileSizeFailureState({
    required this.size,
  });

  @override
  List<Object> get props => [size];
}

final class SelectAndUploadFileExtensionFailureState
    extends SelectAndUploadState {
  final String extensions;
  const SelectAndUploadFileExtensionFailureState({
    required this.extensions,
  });

  @override
  List<Object> get props => [extensions];
}

final class SelectAndUploadFailureState extends SelectAndUploadState {
  final String? message;
  const SelectAndUploadFailureState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
