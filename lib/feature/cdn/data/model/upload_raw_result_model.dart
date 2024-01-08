import '../../../../core/utils/extensions.dart';
import '../../domain/entity/upload_raw_result.dart';

class UploadRawResultModel extends UploadRawResult {
  const UploadRawResultModel({
    required super.uploadDate,
    required super.urn,
  });

  factory UploadRawResultModel.fromJson(Map<String, dynamic> json) =>
      UploadRawResultModel(
        urn: json['urn'],
        uploadDate: json.toLocalJalali('createdDate'),
      );
}
