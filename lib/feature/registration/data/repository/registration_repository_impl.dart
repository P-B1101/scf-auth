import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

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

  const RegistrationRepositoryImpl({
    required this.dataSource,
    required this.repositoryHelper,
  });

  @override
  Future<Either<Failure, SignUpResponse>> signUp(SignUpRequestBody body) =>
      repositoryHelper.tryToLoad(
        () => dataSource.signUp(SignUpRequestBodyModel.fromEntity(body)),
      );
}