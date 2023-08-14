import 'package:equatable/equatable.dart';

import '../../../cdn/domain/entity/province_city.dart';

class AddressInfo extends Equatable {
  final String address;
  final ProvinceCity? province;
  final ProvinceCity? city;
  final double? lat;
  final double? lng;

  const AddressInfo({
    required this.address,
    required this.city,
    required this.lat,
    required this.lng,
    required this.province,
  });

  factory AddressInfo.init() => const AddressInfo(
        address: '',
        city: null,
        lat: null,
        lng: null,
        province: null,
      );

  @override
  List<Object?> get props => [address, province, city, lat, lng];

  AddressInfo copyWith({
    ProvinceCity? province,
    String? address,
  }) =>
      AddressInfo(
        address: address ?? this.address,
        city: city,
        lat: lat,
        lng: lng,
        province: province ?? this.province,
      );

  AddressInfo updateCity(ProvinceCity? city) => AddressInfo(
        address: address,
        city: city,
        lat: lat,
        lng: lng,
        province: province,
      );

  AddressInfo updateLatLng(double? lat, double? lng) => AddressInfo(
        address: address,
        city: city,
        lat: lat,
        lng: lng,
        province: province,
      );

  bool get isValidAddress => address.isNotEmpty;

  bool get isValidProvince => province != null;

  bool get isValidCity => city != null;
}
