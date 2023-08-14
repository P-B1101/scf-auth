part of 'province_city_bloc.dart';

sealed class ProvinceCityEvent extends Equatable {
  const ProvinceCityEvent();

  @override
  List<Object> get props => [];
}

final class GetProvinceCityEvent extends ProvinceCityEvent {}
