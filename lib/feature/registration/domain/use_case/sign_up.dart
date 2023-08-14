import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/sign_up_request_body.dart';
import '../entity/sign_up_response.dart';
import '../repository/registration_repository.dart';

@lazySingleton
class SignUp extends UseCase<SignUpResponse, Params> {
  final RegistrationRepository repository;
  const SignUp({
    required this.repository,
  });

  @override
  Future<Either<Failure, SignUpResponse>> call(Params param) =>
      repository.signUp(param.body);
}

class Params extends NoParams {
  final SignUpRequestBody body;
  const Params({required this.body});

  @override
  List<Object?> get props => [body];
}
