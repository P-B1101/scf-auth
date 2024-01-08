import '../../../../core/utils/extensions.dart';
import '../../domain/entity/upload_file_result.dart';

class UploadFileResultModel extends UploadFileResult {
  const UploadFileResultModel({
    required super.fileName,
    required super.title,
    required super.urn,
    required super.uploadDate,
  });

  factory UploadFileResultModel.fromEntity(UploadFileResult entity) =>
      UploadFileResultModel(
        fileName: entity.fileName,
        title: entity.title,
        urn: entity.urn,
        uploadDate: entity.uploadDate,
      );

  factory UploadFileResultModel.fromJson(Map<String, dynamic> json) =>
      UploadFileResultModel(
        fileName: json['description'] ?? json['fileName'],
        title: json['title'] ?? json['documentTitle'],
        urn: json['urn'] ?? '',
        uploadDate: json.toLocalJalali('uploadedDate'),
      );

  Map<String, dynamic> get toJson => {
        'urn': urn,
        'documentTitle': title,
        'description': fileName,
        'uploadDate': uploadDate?.toDateTime().toIso8601String(),
      };
}
