import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/sign_up_request_body.dart';
import '../entity/sign_up_response.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, SignUpResponse>> signUp(SignUpRequestBody body);

  Future<Either<Failure, String>> sendOtp(String phoneNumber);

  Future<Either<Failure, void>> validateOtp({
    required String code,
    required String otpToken,
  });
}
