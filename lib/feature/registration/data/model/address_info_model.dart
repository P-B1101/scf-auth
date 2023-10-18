import '../../../cdn/data/model/province_city_model.dart';
import '../../domain/entity/address_info.dart';

class AddressInfoModel extends AddressInfo {
  const AddressInfoModel({
    required super.address,
    required super.city,
    required super.lat,
    required super.lng,
    required super.province,
  });

  factory AddressInfoModel.fromEntity(AddressInfo entity) => AddressInfoModel(
        address: entity.address,
        city: entity.city,
        lat: entity.lat,
        lng: entity.lng,
        province: entity.province,
      );

  Map<String, dynamic> get toJson => {
        'province': province == null
            ? null
            : ProvinceCityModel.fromEntity(province!).toJson,
        'city':
            city == null ? null : ProvinceCityModel.fromEntity(city!).toJson,
        'fullAddress': address,
        'latitude': lat,
        'longitude': lng,
      };
}
