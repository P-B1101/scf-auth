import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../database/data/data_source/database_data_source.dart';
import '../../../jwt/manager/jwt_decoder.dart';
import '../../../repository_manager/repository_manager.dart';
import '../../../security/manager/security_manager.dart';
import '../../domain/entity/sign_up_request_body.dart';
import '../../domain/entity/sign_up_response.dart';
import '../../domain/repository/registration_repository.dart';
import '../data_source/registration_data_source.dart';
import '../model/sign_up_request_body_model.dart';
import '../model/token_model.dart';

@LazySingleton(as: RegistrationRepository)
class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationDataSource dataSource;
  final RepositoryHelper repositoryHelper;
  final DataBaseDataSource database;
  final SecurityManager securityManager;
  final MJwtDecoder jwtDecoder;

  const RegistrationRepositoryImpl({
    required this.dataSource,
    required this.repositoryHelper,
    required this.database,
    required this.securityManager,
    required this.jwtDecoder,
  });

  @override
  Future<Either<Failure, SignUpResponse>> signUp(SignUpRequestBody body) =>
      repositoryHelper.tryToAuthLoad(
        (token) => dataSource.signUp(
          body: SignUpRequestBodyModel.fromEntity(body),
          token: token,
        ),
      );

  @override
  Future<Either<Failure, String>> sendOtp(String phoneNumber) =>
      repositoryHelper.tryToLoad(() async {
        final result = await dataSource.sendOtp(phoneNumber);
        _saveTimerDuration(result);
        return result;
      });

  @override
  Future<Either<Failure, void>> validateOtp({
    required String code,
    required String otpToken,
  }) =>
      repositoryHelper.tryToLoad(() async {
        final result =
            await dataSource.validateOtp(otpToken: otpToken, code: code);
        await database.saveAuth(securityManager.encode(result));
      });

  @override
  Future<Either<Failure, String>> resendOtp(String otpToken) =>
      repositoryHelper.tryToLoad(() async {
        final result = await dataSource.resendOtp(otpToken);
        _saveTimerDuration(result);
        return result;
      });

  void _saveTimerDuration(String token) {
    final decodedJson = jwtDecoder.decode(
      token: token,
      converter: (body) => TokenModel.fromJson(body, token),
    );
    Utils.timerDuration = decodedJson.getDuration ?? Utils.timerDuration;
  }
}
