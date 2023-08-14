import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scf_auth/feature/cdn/domain/entity/province_city.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../file_manageer/data/data_source/file_manager_data_source.dart';
import '../../../repository_manager/repository_manager.dart';
import '../../domain/entity/branch_info.dart';
import '../../domain/entity/key_value.dart';
import '../../domain/entity/upload_file_result.dart';
import '../../domain/repository/cdn_repository.dart';
import '../data_source/cdn_data_source.dart';

@LazySingleton(as: CDNRepository)
class CDNRepositoryImpl implements CDNRepository {
  final CDNDataSource dataSource;
  final RepositoryHelper repositoryHelper;
  final FileManagerDataSource fileManagerDataSource;
  const CDNRepositoryImpl({
    required this.dataSource,
    required this.repositoryHelper,
    required this.fileManagerDataSource,
  });

  @override
  Future<Either<Failure, List<KeyValue>>> getKeyValueItem(
    CDNRequestType requestType,
  ) =>
      repositoryHelper
          .tryToLoad(() => dataSource.getKeyValueItems(requestType.toValue));

  @override
  Future<Either<Failure, UploadFileResult>> selectAndUploadFile(String title) =>
      repositoryHelper.tryToLoad(() async {
        final file = await fileManagerDataSource.selectFile();
        final result = await dataSource.uploadFile(file.file);
        return UploadFileResult(fileName: file.name, urn: result, title: title);
      });

  @override
  Future<Either<Failure, List<BranchInfo>>> getBanchList() =>
      repositoryHelper.tryToLoad(() => dataSource.getBranchList());

  @override
  Future<Either<Failure, List<ProvinceCity>>> getListOfProvinces() =>
      repositoryHelper.tryToLoad(() => dataSource.getListOfProvinces());
}
