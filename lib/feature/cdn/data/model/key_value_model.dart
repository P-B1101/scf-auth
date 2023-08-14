import '../../domain/entity/key_value.dart';

class KeyValueModel extends KeyValue {
  const KeyValueModel({
    required super.id,
    required super.title,
  });

  factory KeyValueModel.fromJson(Map<String, dynamic> json) => KeyValueModel(
        id: json['id'],
        title: json['title'],
      );
}
