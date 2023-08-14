import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../domain/entity/select_file_response.dart';
import '../model/select_file_response_model.dart';

abstract class FileManagerDataSource {
  /// Allowed file extensions are [zip,pdf,jpeg,png]
  ///
  /// Max allowed file size is [Utils.maxFileSizeAllowed]
  ///
  /// allowed file extensions are [Utils.allowedExtensions]
  ///
  Future<SelectFileResponse> selectFile();
}

@LazySingleton(as: FileManagerDataSource)
class FileManagerDataSourceImpl implements FileManagerDataSource {
  final FilePicker filePicker;

  const FileManagerDataSourceImpl({
    required this.filePicker,
  });

  @override
  Future<SelectFileResponse> selectFile() async {
    final result = await filePicker.pickFiles(
      withData: true,
      allowedExtensions: Utils.allowedExtensions,
      type: FileType.custom,
      allowMultiple: false,
    );
    if (result == null || result.files.isEmpty) {
      throw const CancelSelectFileException();
    }
    final file = result.files.first;
    if (!file.size.isValidFileSize) throw FileSizeException(file.size);
    if (!Utils.allowedExtensions.contains(file.extension)) {
      throw FileExtensionException(file.extension ?? '-');
    }
    return SelectFileResponseModel.fromFile(file);
  }
}
