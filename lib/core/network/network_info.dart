import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  /// check internet connection using above addresses.
  ///
  /// | Address        | Provider   | Info                                            |
  /// |:---------------|:-----------|:------------------------------------------------|
  /// | 1.1.1.1        | CloudFlare | https://1.1.1.1                                 |
  /// | 1.0.0.1        | CloudFlare | https://1.1.1.1                                 |
  /// | 8.8.8.8        | Google     | https://developers.google.com/speed/public-dns/ |
  /// | 8.8.4.4        | Google     | https://developers.google.com/speed/public-dns/ |
  /// | 208.67.222.222 | OpenDNS    | https://use.opendns.com/                        |
  /// | 208.67.220.220 | OpenDNS    | https://use.opendns.com/
  ///
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  // final InternetConnectionChecker checker;

  // const NetworkInfoImpl(
      //   {
      //   required this.checker,
      // }
      // );

  @override
  Future<bool> get isConnected async => true;
  // checker.hasConnection;
}
