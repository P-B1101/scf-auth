import '../../domain/entity/province_city.dart';

class ProvinceCityModel extends ProvinceCity {
  const ProvinceCityModel({
    required super.cities,
    required super.id,
    required super.title,
  });

  factory ProvinceCityModel.fromJson(Map<String, dynamic> json) =>
      ProvinceCityModel(
        cities: () {
          final value = json['cities'];
          if (value is! List) return <ProvinceCity>[];
          return value.map((e) => ProvinceCityModel.fromJson(e)).toList();
        }(),
        id: json['key'],
        title: json['value'],
      );

  factory ProvinceCityModel.fromEntity(ProvinceCity entity) =>
      ProvinceCityModel(
        cities: entity.cities,
        id: entity.id,
        title: entity.title,
      );

  Map<String, dynamic> get toJson => {
        'key': id,
        'value': title,
      };
}
