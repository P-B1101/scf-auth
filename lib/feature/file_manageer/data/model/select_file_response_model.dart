import 'package:file_picker/file_picker.dart';

import '../../domain/entity/select_file_response.dart';

class SelectFileResponseModel extends SelectFileResponse {
  const SelectFileResponseModel({
    required super.file,
    required super.name,
  });

  factory SelectFileResponseModel.fromFile(PlatformFile file) =>
      SelectFileResponseModel(file: file.bytes!, name: file.name);
}
