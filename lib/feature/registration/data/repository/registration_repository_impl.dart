import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scf_auth/feature/database/data/data_source/database_data_source.dart';
import 'package:scf_auth/feature/security/manager/security_manager.dart';

import '../../../../core/error/failures.dart';
import '../../../repository_manager/repository_manager.dart';
import '../../domain/entity/sign_up_request_body.dart';
import '../../domain/entity/sign_up_response.dart';
import '../../domain/repository/registration_repository.dart';
import '../data_source/registration_data_source.dart';
import '../model/sign_up_request_body_model.dart';

@LazySingleton(as: RegistrationRepository)
class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationDataSource dataSource;
  final RepositoryHelper repositoryHelper;
  final DataBaseDataSource database;
  final SecurityManager securityManager;

  const RegistrationRepositoryImpl({
    required this.dataSource,
    required this.repositoryHelper,
    required this.database,
    required this.securityManager,
  });

  @override
  Future<Either<Failure, SignUpResponse>> signUp(SignUpRequestBody body) =>
      repositoryHelper.tryToLoad(
        () => dataSource.signUp(SignUpRequestBodyModel.fromEntity(body)),
      );

  @override
  Future<Either<Failure, String>> sendOtp(String phoneNumber) =>
      repositoryHelper.tryToLoad(() => dataSource.sendOtp(phoneNumber));

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
}
