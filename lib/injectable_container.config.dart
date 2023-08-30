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
    as _i15;
import 'package:scf_auth/feature/cdn/data/repository/cdn_repository_impl.dart'
    as _i24;
import 'package:scf_auth/feature/cdn/domain/repository/cdn_repository.dart'
    as _i23;
import 'package:scf_auth/feature/cdn/domain/use_case/get_branch_list.dart'
    as _i25;
import 'package:scf_auth/feature/cdn/domain/use_case/get_key_value_item.dart'
    as _i26;
import 'package:scf_auth/feature/cdn/domain/use_case/get_list_of_provinces.dart'
    as _i27;
import 'package:scf_auth/feature/cdn/domain/use_case/select_and_upload_file.dart'
    as _i31;
import 'package:scf_auth/feature/cdn/presentation/bloc/branch_info_bloc.dart'
    as _i37;
import 'package:scf_auth/feature/cdn/presentation/bloc/key_value_item_bloc.dart'
    as _i36;
import 'package:scf_auth/feature/cdn/presentation/bloc/province_city_bloc.dart'
    as _i28;
import 'package:scf_auth/feature/cdn/presentation/bloc/select_and_upload_bloc.dart'
    as _i39;
import 'package:scf_auth/feature/database/data/data_source/database_data_source.dart'
    as _i16;
import 'package:scf_auth/feature/database/data/repository/database_repository_impl.dart'
    as _i18;
import 'package:scf_auth/feature/database/domain/repository/database_repository.dart'
    as _i17;
import 'package:scf_auth/feature/file_manageer/data/data_source/file_manager_data_source.dart'
    as _i19;
import 'package:scf_auth/feature/registration/data/data_source/registration_data_source.dart'
    as _i10;
import 'package:scf_auth/feature/registration/data/repository/registration_repository_impl.dart'
    as _i30;
import 'package:scf_auth/feature/registration/domain/repository/registration_repository.dart'
    as _i29;
import 'package:scf_auth/feature/registration/domain/use_case/send_otp.dart'
    as _i32;
import 'package:scf_auth/feature/registration/domain/use_case/sign_up.dart'
    as _i33;
import 'package:scf_auth/feature/registration/domain/use_case/validate_otp.dart'
    as _i35;
import 'package:scf_auth/feature/registration/presentation/bloc/otp_bloc.dart'
    as _i38;
import 'package:scf_auth/feature/registration/presentation/bloc/sign_up_bloc.dart'
    as _i34;
import 'package:scf_auth/feature/registration/presentation/cubit/registration_dialog_controller_cubit.dart'
    as _i11;
import 'package:scf_auth/feature/repository_manager/repository_manager.dart'
    as _i22;
import 'package:scf_auth/feature/security/manager/security_manager.dart'
    as _i12;
import 'package:scf_auth/feature/toast/manager/toast_manager.dart' as _i14;
import 'package:scf_auth/feature/token/ata/data_source/refresh_token_data_source.dart'
    as _i9;
import 'package:scf_auth/feature/token/ata/repository/token_repository_impl.dart'
    as _i21;
import 'package:scf_auth/feature/token/domain/repository/token_repository.dart'
    as _i20;
import 'package:scf_auth/injectable_container.dart' as _i40;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

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
    gh.lazySingleton<_i10.RegistrationDataSource>(
        () => _i10.RegistrationDataSourceImpl(
              apiCaller: gh<_i3.ApiCaller>(),
              client: gh<_i7.MyClient>(),
            ));
    gh.factory<_i11.RegistrationDialogControllerCubit>(
        () => _i11.RegistrationDialogControllerCubit());
    gh.lazySingleton<_i12.SecurityManager>(() => _i12.SecurityManagerImpl());
    await gh.lazySingletonAsync<_i13.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i14.ToastManager>(
        () => _i14.ToastManagerImpl(fToast: gh<_i5.FToast>()));
    gh.lazySingleton<_i15.CDNDataSource>(() => _i15.CDNDataSourceImpl(
          apiCaller: gh<_i3.ApiCaller>(),
          client: gh<_i7.MyClient>(),
        ));
    gh.lazySingleton<_i16.DataBaseDataSource>(() => _i16.DatabaseDataSourceImpl(
        sharedPreferences: gh<_i13.SharedPreferences>()));
    gh.lazySingleton<_i17.DatabaseRepository>(() => _i18.DatabaseRepositoryImpl(
          dataSource: gh<_i16.DataBaseDataSource>(),
          securityManager: gh<_i12.SecurityManager>(),
        ));
    gh.lazySingleton<_i19.FileManagerDataSource>(
        () => _i19.FileManagerDataSourceImpl(filePicker: gh<_i6.FilePicker>()));
    gh.lazySingleton<_i20.TokenRepository>(() => _i21.TokenRepositoryImpl(
          dataSource: gh<_i9.RefreshTokenDataSource>(),
          database: gh<_i16.DataBaseDataSource>(),
          securityManager: gh<_i12.SecurityManager>(),
        ));
    gh.lazySingleton<_i22.RepositoryHelper>(() => _i22.RepositoryHelperImpl(
          networkInfo: gh<_i8.NetworkInfo>(),
          tokenRepository: gh<_i20.TokenRepository>(),
          databaseDataSource: gh<_i16.DataBaseDataSource>(),
          securityManager: gh<_i12.SecurityManager>(),
        ));
    gh.lazySingleton<_i23.CDNRepository>(() => _i24.CDNRepositoryImpl(
          dataSource: gh<_i15.CDNDataSource>(),
          repositoryHelper: gh<_i22.RepositoryHelper>(),
          fileManagerDataSource: gh<_i19.FileManagerDataSource>(),
        ));
    gh.lazySingleton<_i25.GetBranchList>(
        () => _i25.GetBranchList(repository: gh<_i23.CDNRepository>()));
    gh.lazySingleton<_i26.GetKeyValueItem>(
        () => _i26.GetKeyValueItem(repository: gh<_i23.CDNRepository>()));
    gh.lazySingleton<_i27.GetListOfProvinces>(
        () => _i27.GetListOfProvinces(repository: gh<_i23.CDNRepository>()));
    gh.factory<_i28.ProvinceCityBloc>(
        () => _i28.ProvinceCityBloc(gh<_i27.GetListOfProvinces>()));
    gh.lazySingleton<_i29.RegistrationRepository>(
        () => _i30.RegistrationRepositoryImpl(
              dataSource: gh<_i10.RegistrationDataSource>(),
              repositoryHelper: gh<_i22.RepositoryHelper>(),
              database: gh<_i16.DataBaseDataSource>(),
              securityManager: gh<_i12.SecurityManager>(),
            ));
    gh.lazySingleton<_i31.SelectAndUploadFile>(
        () => _i31.SelectAndUploadFile(repository: gh<_i23.CDNRepository>()));
    gh.lazySingleton<_i32.SendOtp>(
        () => _i32.SendOtp(repository: gh<_i29.RegistrationRepository>()));
    gh.lazySingleton<_i33.SignUp>(
        () => _i33.SignUp(repository: gh<_i29.RegistrationRepository>()));
    gh.factory<_i34.SignUpBloc>(() => _i34.SignUpBloc(gh<_i33.SignUp>()));
    gh.lazySingleton<_i35.ValidateOtp>(
        () => _i35.ValidateOtp(repository: gh<_i29.RegistrationRepository>()));
    gh.factory<_i36.ActivityAreaBloc>(
        () => _i36.ActivityAreaBloc(gh<_i26.GetKeyValueItem>()));
    gh.factory<_i36.ActivityTypeBloc>(
        () => _i36.ActivityTypeBloc(gh<_i26.GetKeyValueItem>()));
    gh.factory<_i37.BranchInfoBloc>(
        () => _i37.BranchInfoBloc(gh<_i25.GetBranchList>()));
    gh.factory<_i38.OtpBloc>(() => _i38.OtpBloc(
          gh<_i32.SendOtp>(),
          gh<_i35.ValidateOtp>(),
        ));
    gh.factory<_i39.SelectAndUploadBloc>(
        () => _i39.SelectAndUploadBloc(gh<_i31.SelectAndUploadFile>()));
    return this;
  }
}

class _$RegisterHttpClient extends _i40.RegisterHttpClient {}

class _$RegisterSharedPref extends _i40.RegisterSharedPref {}

class _$RegisterFToast extends _i40.RegisterFToast {}

class _$RegisterFilePicker extends _i40.RegisterFilePicker {}
