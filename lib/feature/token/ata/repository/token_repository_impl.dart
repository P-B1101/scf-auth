import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../database/data/data_source/database_data_source.dart';
import '../../../security/manager/security_manager.dart';
import '../../domain/repository/token_repository.dart';
import '../../manager/refresh_token_manager.dart';
import '../data_source/refresh_token_data_source.dart';

@LazySingleton(as: TokenRepository)
class TokenRepositoryImpl implements TokenRepository {
  final RefreshTokenDataSource dataSource;
  // final AuthDataSource authDataSource;
  final DataBaseDataSource database;
  final SecurityManager securityManager;

  const TokenRepositoryImpl({
    required this.dataSource,
    required this.database,
    // required this.authDataSource,
    required this.securityManager,
  });

  @override
  Future<bool> refreshToken(String oldToken) async {
    if (RefreshTokenManager.isRefreshing) {
      const mill = 500;
      await Future.delayed(const Duration(milliseconds: mill));
      return refreshToken(oldToken);
    }

    try {
      // if (oldToken != _decodeToken(database.getAuth())) return true;
      RefreshTokenManager.isRefreshing = true;
      // final oToken = _decodeAuthData(database.getAuth());
      // final newToken =
      //     await dataSource.refreshToken(LoginRequestBodyModel.fromEntity(
      //   LoginRequestBody.fromRefreshToken(oToken.refreshToken),
      // ));
      // await _saveAuthData(newToken);
      RefreshTokenManager.isRefreshing = false;
      return true;
    } on Exception catch (error) {
      final isUnAuthorizeException = error is UnAuthorizeException;
      await _handleError(isUnAuthorizeException);
      return !isUnAuthorizeException;
    }
  }

  // Future<void> _saveAuthData(LoginResponse info) async {
  //   await database.saveAuth(securityManager.encode(
  //     json.encode(LoginResponseModel.fromEntity(info).toJson),
  //   ));
  // }

  Future<void> _handleError(bool isUnAuthorizeException) async {
    RefreshTokenManager.isRefreshing = false;
    if (isUnAuthorizeException) {
      await database.removeAllData();
    }
  }

  // String _decodeToken(String data) => _decodeAuthData(data).token;

  // LoginResponse _decodeAuthData(String data) =>
  //     LoginResponseModel.fromJson(json.decode(securityManager.decode(data)));
}
