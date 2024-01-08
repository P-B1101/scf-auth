import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/enums.dart';
import '../entity/branch_info.dart';
import '../entity/key_value.dart';
import '../entity/province_city.dart';
import '../entity/upload_file_result.dart';

abstract class CDNRepository {
  Future<Either<Failure, List<KeyValue>>> getKeyValueItem(
    CDNRequestType requestType,
  );

  Future<Either<Failure, List<UploadFileResult>>> selectAndUploadFile(
    String title,
    bool isMultiSelect,
    UploadFileType type,
  );

  Future<Either<Failure, List<BranchInfo>>> getBanchList();

  Future<Either<Failure, List<ProvinceCity>>> getListOfProvinces();

  Future<Either<Failure, void>> startDownloadFile({
    required String urn,
  });
}
