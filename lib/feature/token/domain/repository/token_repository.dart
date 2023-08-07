abstract class TokenRepository {
  Future<bool> refreshToken(String oldToken);
}
