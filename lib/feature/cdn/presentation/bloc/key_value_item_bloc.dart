import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entity/key_value.dart';
import '../../domain/use_case/get_key_value_item.dart';

part 'key_value_item_event.dart';
part 'key_value_item_state.dart';

mixin KeyValueItemMixin<E extends KeyValueItemEvent,
    S extends KeyValueItemState> on Bloc<E, S> {
  Future<void> onGetKeyValueItemEvent(
    GetKeyValueItem getKeyValueItem,
    GetKeyValueItemEvent event,
    Emitter<KeyValueItemState> emit,
  ) async {
    emit(KeyValueItemLoadingState(items: state.items));
    final result = await getKeyValueItem(Params(type: event.requestType));
    final newState = await result.fold(
      (failure) async => failure.toState(state.items),
      (response) async => KeyValueItemSuccessState(items: response),
    );
    emit(newState);
  }
}

@injectable
class ActivityAreaBloc extends Bloc<KeyValueItemEvent, KeyValueItemState>
    with KeyValueItemMixin {
  final GetKeyValueItem _getKeyValueItem;
  ActivityAreaBloc(this._getKeyValueItem) : super(KeyValueItemInitial()) {
    on<GetKeyValueItemEvent>(
      _onGetKeyValueItemEvent,
      transformer: restartable(),
    );
  }

  Future<void> _onGetKeyValueItemEvent(
    GetKeyValueItemEvent event,
    Emitter<KeyValueItemState> emit,
  ) =>
      onGetKeyValueItemEvent(_getKeyValueItem, event, emit);
}

// @injectable
// class ActivityTypeBloc extends Bloc<KeyValueItemEvent, KeyValueItemState>
//     with KeyValueItemMixin {
//   final GetKeyValueItem _getKeyValueItem;
//   ActivityTypeBloc(this._getKeyValueItem) : super(KeyValueItemInitial()) {
//     on<GetKeyValueItemEvent>(
//       _onGetKeyValueItemEvent,
//       transformer: restartable(),
//     );
//   }

//   Future<void> _onGetKeyValueItemEvent(
//     GetKeyValueItemEvent event,
//     Emitter<KeyValueItemState> emit,
//   ) =>
//       onGetKeyValueItemEvent(_getKeyValueItem, event, emit);
// }

extension FailureToState on Failure {
  KeyValueItemState toState(List<KeyValue> items) {
    switch (runtimeType) {
      case ServerFailure:
        return KeyValueItemFailureState(
          message: (this as ServerFailure).message,
          items: items,
        );
    }
    return KeyValueItemFailureState(items: items);
  }
}
