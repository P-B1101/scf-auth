import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../core/utils/typedef.dart';
import '../database/data/data_source/database_data_source.dart';
import '../security/manager/security_manager.dart';
import '../token/domain/repository/token_repository.dart';

abstract class RepositoryHelper {
  Future<Either<Failure, T>> tryToLoad<T>(LoadOrFail<T> loadOrFail);
}

@LazySingleton(as: RepositoryHelper)
class RepositoryHelperImpl implements RepositoryHelper {
  final NetworkInfo networkInfo;
  final TokenRepository tokenRepository;
  final DataBaseDataSource databaseDataSource;
  final SecurityManager securityManager;
  const RepositoryHelperImpl({
    required this.networkInfo,
    required this.tokenRepository,
    required this.databaseDataSource,
    required this.securityManager,
  });

  @override
  Future<Either<Failure, T>> tryToLoad<T>(LoadOrFail<T> loadOrFail) async {
    // TODO: add this part later if needed
    // if (!(await networkInfo.isConnected)) {
    //   return Left(NoInternetConnectionFailure());
    // }
    try {
      return Right(await loadOrFail());
    } on ServerException catch (error) {
      log(error.toString());
      return Left(ServerFailure(message: error.message));
    }
    // on NoUserInfoSavedException {
    //   analytics.exceptionNoUserInfoSaved();
    //   return Left(AuthenticationFailure());
    // }
    on UnAuthorizeException {
      // final temp = databaseDataSource.tryGetAuth();
      // if (temp == null) return Left(AuthenticationFailure());
      // final token = '';
      // final isRefresh = await tokenRepository.refreshToken(token);
      // if (isRefresh) return tryToLoad(loadOrFail);
      await databaseDataSource.removeAllData();
      return Left(AuthenticationFailure());
    } on MultiDeviceException {
      return Left(MultiDeviceFailure());
    } on SocketException catch (error) {
      log(error.toString());
      return const Left(ServerFailure());
    } on Exception catch (error) {
      log(error.toString());
      return const Left(ServerFailure());
    }
  }
}
