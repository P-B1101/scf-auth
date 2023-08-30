import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/registration_repository.dart';

@lazySingleton
class SendOtp extends UseCase<String, Params> {
  final RegistrationRepository repository;
  const SendOtp({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(Params param) =>
      repository.sendOtp(param.phoneNumber);
}

class Params extends NoParams {
  final String phoneNumber;
  const Params({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}
