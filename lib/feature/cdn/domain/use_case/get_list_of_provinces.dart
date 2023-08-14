import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/province_city.dart';
import '../repository/cdn_repository.dart';

@lazySingleton
class GetListOfProvinces extends UseCase<List<ProvinceCity>, NoParams> {
  final CDNRepository repository;
  const GetListOfProvinces({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ProvinceCity>>> call(NoParams param) =>
      repository.getListOfProvinces();
}
