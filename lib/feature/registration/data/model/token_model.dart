import '../../../../core/utils/extensions.dart';
import '../../domain/entity/token.dart';

class TokenModel extends Token {
  const TokenModel({
    required super.expiredAt,
    required super.issuedAt,
    required super.token,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json, String token) =>
      TokenModel(
        expiredAt: () {
          final value = json['code_exp'];
          if (value is! String) return null;
          return int.tryParse(value)?.toDateTime;
        }(),
        issuedAt: () {
          final value = json['iat'];
          if (value is! int) return null;
          return value.toDateTime;
        }(),
        token: token,
      );
}
