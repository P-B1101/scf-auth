import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/registration_repository.dart';

@lazySingleton
class ResendOtp extends UseCase<String, Params> {
  final RegistrationRepository repository;
  const ResendOtp({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(Params param) =>
      repository.resendOtp(param.otpToken);
}

class Params extends NoParams {
  final String otpToken;
  const Params({
    required this.otpToken,
  });

  @override
  List<Object?> get props => [otpToken];
}
