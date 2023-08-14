import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../domain/entity/branch_info.dart';
import '../../domain/use_case/get_branch_list.dart';

part 'branch_info_event.dart';
part 'branch_info_state.dart';

@injectable
class BranchInfoBloc extends Bloc<BranchInfoEvent, BranchInfoState> {
  final GetBranchList _branchList;
  BranchInfoBloc(this._branchList) : super(BranchInfoInitial()) {
    on<GetBranchInfoEvent>(_onGetBranchInfoEvent, transformer: restartable());
  }

  Future<void> _onGetBranchInfoEvent(
    GetBranchInfoEvent event,
    Emitter<BranchInfoState> emit,
  ) async {
    emit(BranchInfoLoadingState(items: state.items));
    final result = await _branchList(const NoParams());
    final newState = await result.fold(
      (failure) async => failure.toState(state.items),
      (response) async => BranchInfoSuccessState(items: response),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  BranchInfoState toState(List<BranchInfo> items) {
    switch (runtimeType) {
      case ServerFailure:
        return BranchInfoFailureState(
          message: (this as ServerFailure).message,
          items: items,
        );
    }
    return BranchInfoFailureState(items: items);
  }
}
