import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/upload_file_result.dart';
import '../repository/cdn_repository.dart';

@lazySingleton
class SelectAndUploadFile extends UseCase<UploadFileResult, Params> {
  final CDNRepository repository;
  const SelectAndUploadFile({
    required this.repository,
  });

  @override
  Future<Either<Failure, UploadFileResult>> call(Params param) =>
      repository.selectAndUploadFile(param.title);
}

class Params extends NoParams {
  final String title;

  const Params({
    required this.title,
  });

  @override
  List<Object?> get props => [title];
}
