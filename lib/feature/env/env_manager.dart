import '../../core/utils/enums.dart';

class EnvManager {
  const EnvManager._();

  static Environment get env => Environment.uat;

  static Uri getUri({
    required String path,
    Map<String, String>? query,
    String? baseUrl,
  }) {
    switch (env) {
      case Environment.dev:
        return Uri.http(baseUrl ?? 'api.holding.local', path, query);
      case Environment.uat:
        return Uri.http('api-uat.holding.local', path, query);
      case Environment.prelive:
        return Uri.https('prelive.negah.ir', path, query);
      case Environment.live:
        return Uri.https('hipay.negah.ir', path, query);
    }
  }

  static String get getAddress {
    switch (env) {
      case Environment.dev:
        return 'api.holding.local';
      case Environment.uat:
        return 'api-uat.holding.local';
      case Environment.prelive:
        return '10.154.51.46';
      case Environment.live:
        return '10.154.51.46';
    }
  }
}
