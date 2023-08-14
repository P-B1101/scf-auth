import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/enums.dart';
import '../entity/key_value.dart';
import '../repository/cdn_repository.dart';

@lazySingleton
class GetKeyValueItem extends UseCase<List<KeyValue>, Params> {
  final CDNRepository repository;
  const GetKeyValueItem({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<KeyValue>>> call(Params param) =>
      repository.getKeyValueItem(param.type);
}

class Params extends NoParams {
  final CDNRequestType type;
  const Params({
    required this.type,
  });

  @override
  List<Object?> get props => [type];
}
