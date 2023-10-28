import 'package:scf_auth/core/utils/extensions.dart';

import '../../domain/entity/director.dart';

class DirectorModel extends Director {
  const DirectorModel({
    required super.name,
    required super.nationalCode,
    required super.position,
    required super.birthDate,
  });

  factory DirectorModel.fromEntity(Director entity) => DirectorModel(
        name: entity.name,
        nationalCode: entity.nationalCode,
        position: entity.position,
        birthDate: entity.birthDate,
      );

  factory DirectorModel.fromJson(Map<String, dynamic> json) => DirectorModel(
        name: json['fullName'],
        nationalCode: json['nationalCode'],
        position: () {
          final value = json['position'];
          if (value is! String) return null;
          return value.toPosition;
        }(),
        birthDate: () {
          final value = json['birthDate'];
          if (value is! String) return null;
          return value.toJalaliLocal;
        }(),
      );

  Map<String, dynamic> get toJson => {
        'fullName': name,
        'position': position?.toValue,
        'nationalCode': nationalCode,
        'birthDate': birthDate?.toValue,
      };
}
