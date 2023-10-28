import '../../domain/entity/key_value.dart';

class KeyValueModel extends KeyValue {
  const KeyValueModel({
    required super.id,
    required super.title,
  });

  factory KeyValueModel.fromJson(Map<String, dynamic> json) => KeyValueModel(
        id: json['key'],
        title: json['value'],
      );

  factory KeyValueModel.fromEntity(KeyValue entity) => KeyValueModel(
        id: entity.id,
        title: entity.title,
      );

  Map<String, dynamic> get toJson => {
        'key': id,
        'value': title,
      };
}
