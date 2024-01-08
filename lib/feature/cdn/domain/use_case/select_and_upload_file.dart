import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scf_auth/core/utils/enums.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/upload_file_result.dart';
import '../repository/cdn_repository.dart';

@lazySingleton
class SelectAndUploadFile extends UseCase<List<UploadFileResult>, Params> {
  final CDNRepository repository;
  const SelectAndUploadFile({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<UploadFileResult>>> call(Params param) =>
      repository.selectAndUploadFile(
        param.title,
        param.isMultiSelect,
        param.type,
      );
}

class Params extends NoParams {
  final String title;
  final bool isMultiSelect;
  final UploadFileType type;

  const Params({
    required this.title,
    required this.isMultiSelect,
    required this.type,
  });

  @override
  List<Object?> get props => [
        title,
        isMultiSelect,
        type,
      ];
}
