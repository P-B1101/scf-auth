import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/registration_repository.dart';

@lazySingleton
class ValidateOtp extends UseCase<void, Params> {
  final RegistrationRepository repository;
  const ValidateOtp({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(Params param) => repository.validateOtp(
        code: param.code,
        otpToken: param.otpToken,
        isFollowUp: param.isFollowUp,
      );
}

class Params extends NoParams {
  final String code;
  final String otpToken;
  final bool isFollowUp;
  const Params({
    required this.code,
    required this.otpToken,
    required this.isFollowUp,
  });

  @override
  List<Object?> get props => [code, otpToken, isFollowUp];
}
