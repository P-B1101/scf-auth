import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entity/upload_file_result.dart';
import '../../domain/use_case/select_and_upload_file.dart';

part 'select_and_upload_event.dart';
part 'select_and_upload_state.dart';

@injectable
class SelectAndUploadBloc
    extends Bloc<SelectAndUploadEvent, SelectAndUploadState> {
  final SelectAndUploadFile _selectAndUploadFile;
  SelectAndUploadBloc(this._selectAndUploadFile)
      : super(SelectAndUploadInitial()) {
    on<StartSelectAndUploadEvent>(
      _onStartSelectAndUploadEvent,
      transformer: droppable(),
    );
  }

  Future<void> _onStartSelectAndUploadEvent(
    StartSelectAndUploadEvent event,
    Emitter<SelectAndUploadState> emit,
  ) async {
    emit(SelectAndUploadLoadingState());
    final result = await _selectAndUploadFile(Params(
      title: event.title,
      isMultiSelect: event.isMultiSelect,
      type: event.type,
    ));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => SelectAndUploadSuccessState(result: response),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  SelectAndUploadState get toState {
    switch (this) {
      case ServerFailure():
        return SelectAndUploadFailureState(
          message: (this as ServerFailure).message,
        );
      case FileSizeFailure():
        return SelectAndUploadFileSizeFailureState(
          size: (this as FileSizeFailure).size,
        );
      case FileExtensionFailure():
        return SelectAndUploadFileExtensionFailureState(
          extensions: (this as FileExtensionFailure).extensions,
        );
      case CancelSelectFileFailure():
        return SelectAndUploadInitial();
    }
    return const SelectAndUploadFailureState();
  }
}
