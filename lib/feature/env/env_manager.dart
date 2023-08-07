import '../../core/utils/enums.dart';

class EnvManager {
  const EnvManager._();

  static Environment get env => Environment.dev;

  static Uri getUri({
    required String path,
    Map<String, String>? query,
  }) {
    switch (env) {
      case Environment.dev:
        return Uri.http('10.154.51.46:8090', path, query);
      case Environment.stage:
        return Uri.https('stage.negah.ir', path, query);
      case Environment.prelive:
        return Uri.https('prelive.negah.ir', path, query);
      case Environment.live:
        return Uri.https('hipay.negah.ir', path, query);
    }
  }

  static String get getAddress {
    switch (env) {
      case Environment.dev:
        return '10.154.51.46';
      case Environment.stage:
        return '10.154.51.46';
      case Environment.prelive:
        return '10.154.51.46';
      case Environment.live:
        return '10.154.51.46';
    }
  }
}
