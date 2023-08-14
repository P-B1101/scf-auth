import 'package:dartz/dartz.dart';
import 'package:scf_auth/feature/cdn/domain/entity/province_city.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/enums.dart';
import '../entity/branch_info.dart';
import '../entity/key_value.dart';
import '../entity/upload_file_result.dart';

abstract class CDNRepository {
  Future<Either<Failure, List<KeyValue>>> getKeyValueItem(
    CDNRequestType requestType,
  );

  Future<Either<Failure, UploadFileResult>> selectAndUploadFile(String title);

  Future<Either<Failure, List<BranchInfo>>> getBanchList();

  Future<Either<Failure, List<ProvinceCity>>> getListOfProvinces();
}
