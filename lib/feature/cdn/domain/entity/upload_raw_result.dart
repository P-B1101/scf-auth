import 'package:equatable/equatable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class UploadRawResult extends Equatable {
  final String urn;
  final Jalali? uploadDate;

  const UploadRawResult({
    required this.urn,
    required this.uploadDate,
  });

  @override
  List<Object?> get props => [
        urn,
        uploadDate?.toDateTime().toIso8601String(),
      ];
}
