import 'package:dartz/dartz.dart';
import 'package:scf_auth/feature/cdn/domain/entity/key_value.dart';
import 'package:scf_auth/core/error/failures.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, List<KeyValue>>> getActivityAreaItems();

}
