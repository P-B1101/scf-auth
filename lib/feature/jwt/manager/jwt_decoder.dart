import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scf_auth/core/utils/typedef.dart';

abstract class MJwtDecoder {
  T decode<T>({
    required String token,
    required ConvertToModel<T> converter,
  });
}

@LazySingleton(as: MJwtDecoder)
class MJwtDecoderImpl implements MJwtDecoder {
  final JwtDecoder decoder;
  const MJwtDecoderImpl({
    required this.decoder,
  });

  @override
  T decode<T>({
    required String token,
    required ConvertToModel<T> converter,
  }) {
    final decodedToken = JwtDecoder.decode(token);
    return converter(decodedToken);
  }
}
