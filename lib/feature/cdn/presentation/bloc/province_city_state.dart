part of 'province_city_bloc.dart';

sealed class ProvinceCityState extends Equatable {
final List<ProvinceCity> items;

  const ProvinceCityState({
    this.items = const [],
  });

  @override
  List<Object?> get props => [items];
}

final class ProvinceCityInitial extends ProvinceCityState {}

final class ProvinceCityLoadingState extends ProvinceCityState {
  const ProvinceCityLoadingState({
    required super.items,
  });
}

final class ProvinceCitySuccessState extends ProvinceCityState {
  const ProvinceCitySuccessState({
    required super.items,
  });
}

final class ProvinceCityFailureState extends ProvinceCityState {
  final String? message;
  const ProvinceCityFailureState({
    this.message,
    required super.items,
  });

  @override
  List<Object?> get props => [items, message];
}
