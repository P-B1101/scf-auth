import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';

abstract class SecurityManager {
  String encode(String data);
  String decode(String encodedData);
}

@LazySingleton(as: SecurityManager)
class SecurityManagerImpl implements SecurityManager {
  late final Encrypter encrypter;
  late final IV iv;
  SecurityManagerImpl() {
    iv = IV.fromLength(16);
    encrypter = Encrypter(AES(Key.fromUtf8(_key)));
  }

  @override
  String decode(String encodedData) =>
      encrypter.decrypt(Encrypted.fromBase64(encodedData), iv: iv);

  @override
  String encode(String data) {
    return encrypter.encrypt(data, iv: iv).base64;
  }
}

const _key = '6cOrLyZkKF2gRPXWVGmcjKCeeIFWwOF3';
