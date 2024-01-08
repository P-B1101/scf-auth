import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scf_auth/feature/file_manageer/data/data_source/file_manager_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../repository_manager/repository_manager.dart';
import '../../domain/entity/branch_info.dart';
import '../../domain/entity/key_value.dart';
import '../../domain/entity/province_city.dart';
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
  Future<Either<Failure, List<UploadFileResult>>> selectAndUploadFile(
    String title,
    bool isMultiSelect,
    UploadFileType type,
  ) =>
      repositoryHelper.tryToAuthLoad((token) async {
        final files = await fileManagerDataSource.selectFile(isMultiSelect);
        final result = await Future.wait(files.map((e) => dataSource.uploadFile(
              token: token,
              file: e.file,
              name: e.name,
              type: type,
            )));
        final response = <UploadFileResult>[];
        for (int i = 0; i < files.length; i++) {
          response.add(UploadFileResult(
            fileName: files[i].name,
            urn: result[i].urn,
            title: title,
            uploadDate: result[i].uploadDate,
          ));
        }
        return response;
      });

  @override
  Future<Either<Failure, List<BranchInfo>>> getBanchList() =>
      repositoryHelper.tryToLoad(() => dataSource.getBranchList());

  @override
  Future<Either<Failure, List<ProvinceCity>>> getListOfProvinces() =>
      repositoryHelper.tryToLoad(() => dataSource.getListOfProvinces());

  @override
  Future<Either<Failure, void>> startDownloadFile({
    required String urn,
  }) =>
      repositoryHelper.tryToAuthLoad(
          (token) => dataSource.downloadFile(token: token, urn: urn));
}
