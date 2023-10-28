import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/sign_up_request_body.dart';
import '../repository/registration_repository.dart';

@lazySingleton
class GetSavedRegistrationInfo extends UseCase<SignUpRequestBody, NoParams> {
  final RegistrationRepository repository;
  const GetSavedRegistrationInfo({
    required this.repository,
  });

  @override
  Future<Either<Failure, SignUpRequestBody>> call(NoParams param) =>
      repository.getSavedRegistrationInfo();
}
