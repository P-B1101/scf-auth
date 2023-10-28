import '../../domain/entity/upload_file_result.dart';

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

  factory UploadFileResultModel.fromJson(Map<String, dynamic> json) =>
      UploadFileResultModel(
        fileName: json['fileName'] ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: json['documentTitle'],
        urn: json['urn'],
      );

  Map<String, dynamic> get toJson => {
        'documentTitle': title,
        'urn': urn,
        'fileName': fileName,
      };
}
