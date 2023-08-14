import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/branch_info.dart';
import '../repository/cdn_repository.dart';

@lazySingleton
class GetBranchList extends UseCase<List<BranchInfo>, NoParams> {
  final CDNRepository repository;
  const GetBranchList({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<BranchInfo>>> call(NoParams param) =>
      repository.getBanchList();
}
