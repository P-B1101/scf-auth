import 'package:scf_auth/feature/cdn/domain/entity/upload_file_result.dart';

class UploadFileResultModel extends UploadFileResult {
  const UploadFileResultModel({
    required super.fileName,
    required super.title,
    required super.urn,
  });

  factory UploadFileResultModel.fromEntity(UploadFileResult entity) =>
      UploadFileResultModel(
        fileName: entity.fileName,
        title: entity.title,
        urn: entity.urn,
      );

  Map<String, dynamic> get toJson => {
        'documentTitle': title,
        'urn': urn,
        'fileName': fileName,
      };
}
