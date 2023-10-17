import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/time_holder.dart';

part 'timer_controller_state.dart';

@injectable
class TimerControllerCubit extends Cubit<TimerControllerState> {
  TimerControllerCubit() : super(TimerControllerState.init());

  TimerControllerState addEvent(String id) {
    final newState = state.addEvent(id);
    emit(newState);
    return newState;
  }

  bool tick(String id) {
    final newState = state.tick(id);
    final mState = newState.clearEvents;
    emit(mState);
    return newState.getDurationOf(id) < Duration.zero;
  }

  void startTimer(String id) {
    final newState = state.addEvent(id);
    emit(newState.copyWith(startTimer: true));
  }
}
