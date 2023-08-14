// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:file_picker/file_picker.dart' as _i6;
import 'package:fluttertoast/fluttertoast.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:scf_auth/core/network/network_info.dart' as _i8;
import 'package:scf_auth/feature/api/manager/api_caller.dart' as _i3;
import 'package:scf_auth/feature/api/manager/my_client.dart' as _i7;
import 'package:scf_auth/feature/cdn/data/data_source/cdn_data_source.dart'
    as _i14;
import 'package:scf_auth/feature/cdn/data/repository/cdn_repository_impl.dart'
    as _i23;
import 'package:scf_auth/feature/cdn/domain/repository/cdn_repository.dart'
    as _i22;
import 'package:scf_auth/feature/cdn/domain/use_case/get_branch_list.dart'
    as _i24;
import 'package:scf_auth/feature/cdn/domain/use_case/get_key_value_item.dart'
    as _i25;
import 'package:scf_auth/feature/cdn/domain/use_case/get_list_of_provinces.dart'
    as _i26;
import 'package:scf_auth/feature/cdn/domain/use_case/select_and_upload_file.dart'
    as _i28;
import 'package:scf_auth/feature/cdn/presentation/bloc/branch_info_bloc.dart'
    as _i30;
import 'package:scf_auth/feature/cdn/presentation/bloc/key_value_item_bloc.dart'
    as _i29;
import 'package:scf_auth/feature/cdn/presentation/bloc/province_city_bloc.dart'
    as _i27;
import 'package:scf_auth/feature/cdn/presentation/bloc/select_and_upload_bloc.dart'
    as _i31;
import 'package:scf_auth/feature/database/data/data_source/database_data_source.dart'
    as _i15;
import 'package:scf_auth/feature/database/data/repository/database_repository_impl.dart'
    as _i17;
import 'package:scf_auth/feature/database/domain/repository/database_repository.dart'
    as _i16;
import 'package:scf_auth/feature/file_manageer/data/data_source/file_manager_data_source.dart'
    as _i18;
import 'package:scf_auth/feature/registration/presentation/cubit/registration_controller_cubit.dart'
    as _i10;
import 'package:scf_auth/feature/repository_manager/repository_manager.dart'
    as _i21;
import 'package:scf_auth/feature/security/manager/security_manager.dart'
    as _i11;
import 'package:scf_auth/feature/toast/manager/toast_manager.dart' as _i13;
import 'package:scf_auth/feature/token/ata/data_source/refresh_token_data_source.dart'
    as _i9;
import 'package:scf_auth/feature/token/ata/repository/token_repository_impl.dart'
    as _i20;
import 'package:scf_auth/feature/token/domain/repository/token_repository.dart'
    as _i19;
import 'package:scf_auth/injectable_container.dart' as _i32;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

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
    final registerFilePicker = _$RegisterFilePicker();
    final registerSharedPref = _$RegisterSharedPref();
    gh.lazySingleton<_i3.ApiCaller>(() => _i3.ApiCallerImpl());
    gh.lazySingleton<_i4.Client>(() => registerHttpClient.client);
    gh.lazySingleton<_i5.FToast>(() => registerFToast.tosat);
    gh.lazySingleton<_i6.FilePicker>(() => registerFilePicker.tosat);
    gh.lazySingleton<_i7.MyClient>(() => _i7.MyClient(gh<_i4.Client>()));
    gh.lazySingleton<_i8.NetworkInfo>(() => _i8.NetworkInfoImpl());
    gh.lazySingleton<_i9.RefreshTokenDataSource>(
        () => _i9.RefreshTokenDataSourceImpl(
              client: gh<_i7.MyClient>(),
              apiCaller: gh<_i3.ApiCaller>(),
            ));
    gh.factory<_i10.RegistrationControllerCubit>(
        () => _i10.RegistrationControllerCubit());
    gh.lazySingleton<_i11.SecurityManager>(() => _i11.SecurityManagerImpl());
    await gh.lazySingletonAsync<_i12.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i13.ToastManager>(
        () => _i13.ToastManagerImpl(fToast: gh<_i5.FToast>()));
    gh.lazySingleton<_i14.CDNDataSource>(() => _i14.CDNDataSourceImpl(
          apiCaller: gh<_i3.ApiCaller>(),
          client: gh<_i7.MyClient>(),
        ));
    gh.lazySingleton<_i15.DataBaseDataSource>(() => _i15.DatabaseDataSourceImpl(
        sharedPreferences: gh<_i12.SharedPreferences>()));
    gh.lazySingleton<_i16.DatabaseRepository>(() => _i17.DatabaseRepositoryImpl(
          dataSource: gh<_i15.DataBaseDataSource>(),
          securityManager: gh<_i11.SecurityManager>(),
        ));
    gh.lazySingleton<_i18.FileManagerDataSource>(
        () => _i18.FileManagerDataSourceImpl(filePicker: gh<_i6.FilePicker>()));
    gh.lazySingleton<_i19.TokenRepository>(() => _i20.TokenRepositoryImpl(
          dataSource: gh<_i9.RefreshTokenDataSource>(),
          database: gh<_i15.DataBaseDataSource>(),
          securityManager: gh<_i11.SecurityManager>(),
        ));
    gh.lazySingleton<_i21.RepositoryHelper>(() => _i21.RepositoryHelperImpl(
          networkInfo: gh<_i8.NetworkInfo>(),
          tokenRepository: gh<_i19.TokenRepository>(),
          databaseDataSource: gh<_i15.DataBaseDataSource>(),
          securityManager: gh<_i11.SecurityManager>(),
        ));
    gh.lazySingleton<_i22.CDNRepository>(() => _i23.CDNRepositoryImpl(
          dataSource: gh<_i14.CDNDataSource>(),
          repositoryHelper: gh<_i21.RepositoryHelper>(),
          fileManagerDataSource: gh<_i18.FileManagerDataSource>(),
        ));
    gh.lazySingleton<_i24.GetBranchList>(
        () => _i24.GetBranchList(repository: gh<_i22.CDNRepository>()));
    gh.lazySingleton<_i25.GetKeyValueItem>(
        () => _i25.GetKeyValueItem(repository: gh<_i22.CDNRepository>()));
    gh.lazySingleton<_i26.GetListOfProvinces>(
        () => _i26.GetListOfProvinces(repository: gh<_i22.CDNRepository>()));
    gh.factory<_i27.ProvinceCityBloc>(
        () => _i27.ProvinceCityBloc(gh<_i26.GetListOfProvinces>()));
    gh.lazySingleton<_i28.SelectAndUploadFile>(
        () => _i28.SelectAndUploadFile(repository: gh<_i22.CDNRepository>()));
    gh.factory<_i29.ActivityAreaBloc>(
        () => _i29.ActivityAreaBloc(gh<_i25.GetKeyValueItem>()));
    gh.factory<_i29.ActivityTypeBloc>(
        () => _i29.ActivityTypeBloc(gh<_i25.GetKeyValueItem>()));
    gh.factory<_i30.BranchInfoBloc>(
        () => _i30.BranchInfoBloc(gh<_i24.GetBranchList>()));
    gh.factory<_i31.SelectAndUploadBloc>(
        () => _i31.SelectAndUploadBloc(gh<_i28.SelectAndUploadFile>()));
    return this;
  }
}

class _$RegisterHttpClient extends _i32.RegisterHttpClient {}

class _$RegisterSharedPref extends _i32.RegisterSharedPref {}

class _$RegisterFToast extends _i32.RegisterFToast {}

class _$RegisterFilePicker extends _i32.RegisterFilePicker {}
