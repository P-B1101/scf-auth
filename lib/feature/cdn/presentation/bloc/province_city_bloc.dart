import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../domain/entity/province_city.dart';
import '../../domain/use_case/get_list_of_provinces.dart';

part 'province_city_event.dart';
part 'province_city_state.dart';

@injectable
class ProvinceCityBloc extends Bloc<ProvinceCityEvent, ProvinceCityState> {
  final GetListOfProvinces _getProvinceCity;
  ProvinceCityBloc(this._getProvinceCity) : super(ProvinceCityInitial()) {
    on<GetProvinceCityEvent>(_onGetBranchInfoEvent, transformer: restartable());
  }

  Future<void> _onGetBranchInfoEvent(
    GetProvinceCityEvent event,
    Emitter<ProvinceCityState> emit,
  ) async {
    emit(ProvinceCityLoadingState(items: state.items));
    final result = await _getProvinceCity(const NoParams());
    final newState = await result.fold(
      (failure) async => failure.toState(state.items),
      (response) async => ProvinceCitySuccessState(items: response),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  ProvinceCityState toState(List<ProvinceCity> items) {
    switch (runtimeType) {
      case ServerFailure:
        return ProvinceCityFailureState(
          message: (this as ServerFailure).message,
          items: items,
        );
    }
    return ProvinceCityFailureState(items: items);
  }
}
