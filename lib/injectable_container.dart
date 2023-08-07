import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injectable_container.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await getIt.init();
}

// @module
// abstract class RegisterNetworkInfo {
//   @lazySingleton
//   InternetConnectionChecker get info => InternetConnectionChecker();
// }

@module
abstract class RegisterHttpClient {
  @lazySingleton
  http.Client get client => http.Client();
}

@module
abstract class RegisterSharedPref {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@module
abstract class RegisterFToast {
  @lazySingleton
  FToast get tosat => FToast();
}
