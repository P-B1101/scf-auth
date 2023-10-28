import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../domain/entity/sign_up_request_body.dart';
import '../../domain/use_case/get_saved_registration_info.dart';

part 'saved_registration_info_event.dart';
part 'saved_registration_info_state.dart';

@injectable
class SavedRegistrationInfoBloc
    extends Bloc<SavedRegistrationInfoEvent, SavedRegistrationInfoState> {
  final GetSavedRegistrationInfo _getSavedRegistrationInfo;
  SavedRegistrationInfoBloc(this._getSavedRegistrationInfo)
      : super(SavedRegistrationInfoInitial()) {
    on<GetSavedRegistrationInfoEvent>(_onGetSavedRegistrationInfoEvent,
        transformer: restartable());
  }
  Future<void> _onGetSavedRegistrationInfoEvent(
    GetSavedRegistrationInfoEvent event,
    Emitter<SavedRegistrationInfoState> emit,
  ) async {
    emit(SavedRegistrationInfoLoadingState());
    final result = await _getSavedRegistrationInfo(const NoParams());
    final newState = await result.fold(
      (failure) async => failure.toState,
      (item) async => SavedRegistrationInfoSuccessState(item: item),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  SavedRegistrationInfoState get toState => switch (this) {
        ServerFailure(message: String? message) =>
          SavedRegistrationInfoFailureState(message),
        AuthenticationFailure() =>
          SavedRegistrationInfoUnAuthorizeFailureState(),
        _ => const SavedRegistrationInfoFailureState(),
      };
}
