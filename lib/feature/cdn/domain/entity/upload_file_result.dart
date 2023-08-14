import 'package:equatable/equatable.dart';

class UploadFileResult extends Equatable {
  final String urn;
  final String fileName;
  final String title;

  const UploadFileResult({
    required this.fileName,
    required this.urn,
    required this.title,
  });

  @override
  List<Object?> get props => [urn, fileName, title];

  factory UploadFileResult.init() =>
      const UploadFileResult(fileName: '', urn: '', title: '');

  UploadFileResult copyWith({
    String? fileName,
    String? title,
    String? urn,
  }) =>
      UploadFileResult(
        fileName: fileName ?? this.fileName,
        urn: urn ?? this.urn,
        title: title ?? this.title,
      );

  bool get invalidFile => fileName.isEmpty;

  bool get invalidTitle => title.isEmpty;
}
