// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fluttertoast/fluttertoast.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:scf_auth/core/network/network_info.dart' as _i7;
import 'package:scf_auth/feature/api/manager/api_caller.dart' as _i3;
import 'package:scf_auth/feature/api/manager/my_client.dart' as _i6;
import 'package:scf_auth/feature/database/data/data_source/database_data_source.dart'
    as _i12;
import 'package:scf_auth/feature/database/data/repository/database_repository_impl.dart'
    as _i14;
import 'package:scf_auth/feature/database/domain/repository/database_repository.dart'
    as _i13;
import 'package:scf_auth/feature/repository_manager/repository_manager.dart'
    as _i17;
import 'package:scf_auth/feature/security/manager/security_manager.dart' as _i9;
import 'package:scf_auth/feature/toast/manager/toast_manager.dart' as _i11;
import 'package:scf_auth/feature/token/ata/data_source/refresh_token_data_source.dart'
    as _i8;
import 'package:scf_auth/feature/token/ata/repository/token_repository_impl.dart'
    as _i16;
import 'package:scf_auth/feature/token/domain/repository/token_repository.dart'
    as _i15;
import 'package:scf_auth/injectable_container.dart' as _i18;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerHttpClient = _$RegisterHttpClient();
    final registerFToast = _$RegisterFToast();
    final registerSharedPref = _$RegisterSharedPref();
    gh.lazySingleton<_i3.ApiCaller>(() => _i3.ApiCallerImpl());
    gh.lazySingleton<_i4.Client>(() => registerHttpClient.client);
    gh.lazySingleton<_i5.FToast>(() => registerFToast.tosat);
    gh.lazySingleton<_i6.MyClient>(() => _i6.MyClient(gh<_i4.Client>()));
    gh.lazySingleton<_i7.NetworkInfo>(() => _i7.NetworkInfoImpl());
    gh.lazySingleton<_i8.RefreshTokenDataSource>(
        () => _i8.RefreshTokenDataSourceImpl(
              client: gh<_i6.MyClient>(),
              apiCaller: gh<_i3.ApiCaller>(),
            ));
    gh.lazySingleton<_i9.SecurityManager>(() => _i9.SecurityManagerImpl());
    await gh.lazySingletonAsync<_i10.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i11.ToastManager>(
        () => _i11.ToastManagerImpl(fToast: gh<_i5.FToast>()));
    gh.lazySingleton<_i12.DataBaseDataSource>(() => _i12.DatabaseDataSourceImpl(
        sharedPreferences: gh<_i10.SharedPreferences>()));
    gh.lazySingleton<_i13.DatabaseRepository>(() => _i14.DatabaseRepositoryImpl(
          dataSource: gh<_i12.DataBaseDataSource>(),
          securityManager: gh<_i9.SecurityManager>(),
        ));
    gh.lazySingleton<_i15.TokenRepository>(() => _i16.TokenRepositoryImpl(
          dataSource: gh<_i8.RefreshTokenDataSource>(),
          database: gh<_i12.DataBaseDataSource>(),
          securityManager: gh<_i9.SecurityManager>(),
        ));
    gh.lazySingleton<_i17.RepositoryHelper>(() => _i17.RepositoryHelperImpl(
          networkInfo: gh<_i7.NetworkInfo>(),
          tokenRepository: gh<_i15.TokenRepository>(),
          databaseDataSource: gh<_i12.DataBaseDataSource>(),
          securityManager: gh<_i9.SecurityManager>(),
        ));
    return this;
  }
}

class _$RegisterHttpClient extends _i18.RegisterHttpClient {}

class _$RegisterSharedPref extends _i18.RegisterSharedPref {}

class _$RegisterFToast extends _i18.RegisterFToast {}
