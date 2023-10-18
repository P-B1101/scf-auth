import 'package:scf_auth/core/utils/extensions.dart';

import '../../domain/entity/director.dart';

class DirectorModel extends Director {
  const DirectorModel({
    required super.name,
    required super.nationalCode,
    required super.position,
  });

  factory DirectorModel.fromEntity(Director entity) => DirectorModel(
        name: entity.name,
        nationalCode: entity.nationalCode,
        position: entity.position,
      );

  Map<String, dynamic> get toJson => {
        'fullName': name,
        'position': position.toValue,
        'nationalCode': nationalCode,
      };
}
