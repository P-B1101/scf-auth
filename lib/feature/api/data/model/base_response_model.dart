import '../../../../core/utils/typedef.dart';
import '../../domain/entity/base_response.dart';

class MBaseResponseModel<T> extends MBaseResponse<T> {
  const MBaseResponseModel({
    required super.data,
    required super.message,
  });

  factory MBaseResponseModel.fromJson({
    required Map<String, dynamic> json,
    required ConvertToModel<T> fromJson,
  }) =>
      MBaseResponseModel<T>(
        message: json['errorMessage'] ?? '',
        data: fromJson(json['data']),
      );
}
