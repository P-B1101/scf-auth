import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/sign_up_request_body.dart';
import '../entity/sign_up_response.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, SignUpResponse>> signUp(SignUpRequestBody body);

  Future<Either<Failure, SignUpResponse>> edit(SignUpRequestBody body);

  Future<Either<Failure, String>> sendOtp(
    String phoneNumber,
    String? refrenceCode,
  );

  Future<Either<Failure, String>> resendOtp(String otpToken);

  Future<Either<Failure, void>> validateOtp({
    required String code,
    required String otpToken,
    required bool isFollowUp,
  });

  Future<Either<Failure, SignUpRequestBody>> getSavedRegistrationInfo();
}
