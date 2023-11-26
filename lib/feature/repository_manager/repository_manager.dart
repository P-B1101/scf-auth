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

  Future<Either<Failure, T>> tryToAuthLoad<T>(
      AuthorizedLoadOrFail<T> loadOrFail);
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
  Future<Either<Failure, T>> tryToLoad<T>(LoadOrFail<T> loadOrFail) async =>
      _tryToLoad((token) async => await loadOrFail());

  @override
  Future<Either<Failure, T>> tryToAuthLoad<T>(
    AuthorizedLoadOrFail<T> loadOrFail,
  ) async =>
      _tryToLoad((token) async => await loadOrFail(token!), true);

  Future<Either<Failure, T>> _tryToLoad<T>(
    Future<T> Function(String? token) tryToLoad, [
    bool isAuthorized = false,
  ]) async {
    // TODO: add this part later if needed
    // if (!(await networkInfo.isConnected)) {
    //   return Left(NoInternetConnectionFailure());
    // }
    try {
      String? token;
      if (isAuthorized) {
        final data = databaseDataSource.getAuth();
        final decodedData = securityManager.decode(data);
        // final authInfo = AuthInfoModel.fromJson(json.decode(decodedData));
        token = decodedData;
      }
      return Right(await tryToLoad(token));
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
      log('UnAuthorizeException');
      return Left(AuthenticationFailure());
    }
    // on AccessDeniedException {
    //   log('AccessDeniedException');
    //   return Left(AccessDeniedFailure());
    // }
    on MultiDeviceException {
      log('MultiDeviceException');
      return Left(MultiDeviceFailure());
    } on CancelSelectFileException {
      log('CancelSelectFileException');
      return Left(CancelSelectFileFailure());
    } on FileSizeException catch (error) {
      log(error.toString());
      return Left(FileSizeFailure(error.size));
    } on FileExtensionException catch (error) {
      log(error.toString());
      return Left(FileExtensionFailure(error.extensions));
    } on SocketException catch (error) {
      log(error.toString());
      return const Left(ServerFailure());
    } on Exception catch (error) {
      log(error.toString());
      return const Left(ServerFailure());
    }
  }
}
