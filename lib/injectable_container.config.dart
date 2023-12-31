// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:file_picker/file_picker.dart' as _i6;
import 'package:fluttertoast/fluttertoast.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:jwt_decoder/jwt_decoder.dart' as _i8;
import 'package:scf_auth/core/network/network_info.dart' as _i11;
import 'package:scf_auth/feature/api/manager/api_caller.dart' as _i3;
import 'package:scf_auth/feature/api/manager/my_client.dart' as _i10;
import 'package:scf_auth/feature/cdn/data/data_source/cdn_data_source.dart'
    as _i18;
import 'package:scf_auth/feature/cdn/data/repository/cdn_repository_impl.dart'
    as _i27;
import 'package:scf_auth/feature/cdn/domain/repository/cdn_repository.dart'
    as _i26;
import 'package:scf_auth/feature/cdn/domain/use_case/get_branch_list.dart'
    as _i28;
import 'package:scf_auth/feature/cdn/domain/use_case/get_key_value_item.dart'
    as _i29;
import 'package:scf_auth/feature/cdn/domain/use_case/get_list_of_provinces.dart'
    as _i30;
import 'package:scf_auth/feature/cdn/domain/use_case/select_and_upload_file.dart'
    as _i35;
import 'package:scf_auth/feature/cdn/presentation/bloc/branch_info_bloc.dart'
    as _i40;
import 'package:scf_auth/feature/cdn/presentation/bloc/key_value_item_bloc.dart'
    as _i39;
import 'package:scf_auth/feature/cdn/presentation/bloc/province_city_bloc.dart'
    as _i31;
import 'package:scf_auth/feature/cdn/presentation/bloc/select_and_upload_bloc.dart'
    as _i45;
import 'package:scf_auth/feature/database/data/data_source/database_data_source.dart'
    as _i19;
import 'package:scf_auth/feature/database/data/repository/database_repository_impl.dart'
    as _i21;
import 'package:scf_auth/feature/database/domain/repository/database_repository.dart'
    as _i20;
import 'package:scf_auth/feature/file_manageer/data/data_source/file_manager_data_source.dart'
    as _i22;
import 'package:scf_auth/feature/jwt/manager/jwt_decoder.dart' as _i9;
import 'package:scf_auth/feature/registration/data/data_source/registration_data_source.dart'
    as _i13;
import 'package:scf_auth/feature/registration/data/repository/registration_repository_impl.dart'
    as _i33;
import 'package:scf_auth/feature/registration/domain/repository/registration_repository.dart'
    as _i32;
import 'package:scf_auth/feature/registration/domain/use_case/edit.dart'
    as _i41;
import 'package:scf_auth/feature/registration/domain/use_case/get_saved_registration_info.dart'
    as _i42;
import 'package:scf_auth/feature/registration/domain/use_case/resend_otp.dart'
    as _i34;
import 'package:scf_auth/feature/registration/domain/use_case/send_otp.dart'
    as _i36;
import 'package:scf_auth/feature/registration/domain/use_case/sign_up.dart'
    as _i37;
import 'package:scf_auth/feature/registration/domain/use_case/validate_otp.dart'
    as _i38;
import 'package:scf_auth/feature/registration/presentation/bloc/otp_bloc.dart'
    as _i43;
import 'package:scf_auth/feature/registration/presentation/bloc/saved_registration_info_bloc.dart'
    as _i44;
import 'package:scf_auth/feature/registration/presentation/bloc/sign_up_bloc.dart'
    as _i46;
import 'package:scf_auth/feature/registration/presentation/cubit/follow_up_dialog_controller_cubit.dart'
    as _i7;
import 'package:scf_auth/feature/registration/presentation/cubit/registration_dialog_controller_cubit.dart'
    as _i14;
import 'package:scf_auth/feature/repository_manager/repository_manager.dart'
    as _i25;
import 'package:scf_auth/feature/security/manager/security_manager.dart'
    as _i15;
import 'package:scf_auth/feature/toast/manager/toast_manager.dart' as _i17;
import 'package:scf_auth/feature/token/ata/data_source/refresh_token_data_source.dart'
    as _i12;
import 'package:scf_auth/feature/token/ata/repository/token_repository_impl.dart'
    as _i24;
import 'package:scf_auth/feature/token/domain/repository/token_repository.dart'
    as _i23;
import 'package:scf_auth/injectable_container.dart' as _i47;
import 'package:shared_preferences/shared_preferences.dart' as _i16;

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
    final registerJwtDecoder = _$RegisterJwtDecoder();
    final registerSharedPref = _$RegisterSharedPref();
    gh.lazySingleton<_i3.ApiCaller>(() => _i3.ApiCallerImpl());
    gh.lazySingleton<_i4.Client>(() => registerHttpClient.client);
    gh.lazySingleton<_i5.FToast>(() => registerFToast.tosat);
    gh.lazySingleton<_i6.FilePicker>(() => registerFilePicker.tosat);
    gh.factory<_i7.FollowUpDialogControllerCubit>(
        () => _i7.FollowUpDialogControllerCubit());
    gh.lazySingleton<_i8.JwtDecoder>(() => registerJwtDecoder.decoder);
    gh.lazySingleton<_i9.MJwtDecoder>(
        () => _i9.MJwtDecoderImpl(decoder: gh<_i8.JwtDecoder>()));
    gh.lazySingleton<_i10.MyClient>(() => _i10.MyClient(gh<_i4.Client>()));
    gh.lazySingleton<_i11.NetworkInfo>(() => _i11.NetworkInfoImpl());
    gh.lazySingleton<_i12.RefreshTokenDataSource>(
        () => _i12.RefreshTokenDataSourceImpl(
              client: gh<_i10.MyClient>(),
              apiCaller: gh<_i3.ApiCaller>(),
            ));
    gh.lazySingleton<_i13.RegistrationDataSource>(
        () => _i13.RegistrationDataSourceImpl(
              apiCaller: gh<_i3.ApiCaller>(),
              client: gh<_i10.MyClient>(),
            ));
    gh.factory<_i14.RegistrationDialogControllerCubit>(
        () => _i14.RegistrationDialogControllerCubit());
    gh.lazySingleton<_i15.SecurityManager>(() => _i15.SecurityManagerImpl());
    await gh.lazySingletonAsync<_i16.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i17.ToastManager>(
        () => _i17.ToastManagerImpl(fToast: gh<_i5.FToast>()));
    gh.lazySingleton<_i18.CDNDataSource>(() => _i18.CDNDataSourceImpl(
          apiCaller: gh<_i3.ApiCaller>(),
          client: gh<_i10.MyClient>(),
        ));
    gh.lazySingleton<_i19.DataBaseDataSource>(() => _i19.DatabaseDataSourceImpl(
        sharedPreferences: gh<_i16.SharedPreferences>()));
    gh.lazySingleton<_i20.DatabaseRepository>(() => _i21.DatabaseRepositoryImpl(
          dataSource: gh<_i19.DataBaseDataSource>(),
          securityManager: gh<_i15.SecurityManager>(),
        ));
    gh.lazySingleton<_i22.FileManagerDataSource>(
        () => _i22.FileManagerDataSourceImpl(filePicker: gh<_i6.FilePicker>()));
    gh.lazySingleton<_i23.TokenRepository>(() => _i24.TokenRepositoryImpl(
          dataSource: gh<_i12.RefreshTokenDataSource>(),
          database: gh<_i19.DataBaseDataSource>(),
          securityManager: gh<_i15.SecurityManager>(),
        ));
    gh.lazySingleton<_i25.RepositoryHelper>(() => _i25.RepositoryHelperImpl(
          networkInfo: gh<_i11.NetworkInfo>(),
          tokenRepository: gh<_i23.TokenRepository>(),
          databaseDataSource: gh<_i19.DataBaseDataSource>(),
          securityManager: gh<_i15.SecurityManager>(),
        ));
    gh.lazySingleton<_i26.CDNRepository>(() => _i27.CDNRepositoryImpl(
          dataSource: gh<_i18.CDNDataSource>(),
          repositoryHelper: gh<_i25.RepositoryHelper>(),
          fileManagerDataSource: gh<_i22.FileManagerDataSource>(),
        ));
    gh.lazySingleton<_i28.GetBranchList>(
        () => _i28.GetBranchList(repository: gh<_i26.CDNRepository>()));
    gh.lazySingleton<_i29.GetKeyValueItem>(
        () => _i29.GetKeyValueItem(repository: gh<_i26.CDNRepository>()));
    gh.lazySingleton<_i30.GetListOfProvinces>(
        () => _i30.GetListOfProvinces(repository: gh<_i26.CDNRepository>()));
    gh.factory<_i31.ProvinceCityBloc>(
        () => _i31.ProvinceCityBloc(gh<_i30.GetListOfProvinces>()));
    gh.lazySingleton<_i32.RegistrationRepository>(
        () => _i33.RegistrationRepositoryImpl(
              dataSource: gh<_i13.RegistrationDataSource>(),
              repositoryHelper: gh<_i25.RepositoryHelper>(),
              database: gh<_i19.DataBaseDataSource>(),
              securityManager: gh<_i15.SecurityManager>(),
              jwtDecoder: gh<_i9.MJwtDecoder>(),
              cdnDataSource: gh<_i18.CDNDataSource>(),
            ));
    gh.lazySingleton<_i34.ResendOtp>(
        () => _i34.ResendOtp(repository: gh<_i32.RegistrationRepository>()));
    gh.lazySingleton<_i35.SelectAndUploadFile>(
        () => _i35.SelectAndUploadFile(repository: gh<_i26.CDNRepository>()));
    gh.lazySingleton<_i36.SendOtp>(
        () => _i36.SendOtp(repository: gh<_i32.RegistrationRepository>()));
    gh.lazySingleton<_i37.SignUp>(
        () => _i37.SignUp(repository: gh<_i32.RegistrationRepository>()));
    gh.lazySingleton<_i38.ValidateOtp>(
        () => _i38.ValidateOtp(repository: gh<_i32.RegistrationRepository>()));
    gh.factory<_i39.ActivityAreaBloc>(
        () => _i39.ActivityAreaBloc(gh<_i29.GetKeyValueItem>()));
    gh.factory<_i40.BranchInfoBloc>(
        () => _i40.BranchInfoBloc(gh<_i28.GetBranchList>()));
    gh.lazySingleton<_i41.Edit>(
        () => _i41.Edit(repository: gh<_i32.RegistrationRepository>()));
    gh.lazySingleton<_i42.GetSavedRegistrationInfo>(() =>
        _i42.GetSavedRegistrationInfo(
            repository: gh<_i32.RegistrationRepository>()));
    gh.factory<_i43.OtpBloc>(() => _i43.OtpBloc(
          gh<_i36.SendOtp>(),
          gh<_i38.ValidateOtp>(),
          gh<_i34.ResendOtp>(),
        ));
    gh.factory<_i44.SavedRegistrationInfoBloc>(() =>
        _i44.SavedRegistrationInfoBloc(gh<_i42.GetSavedRegistrationInfo>()));
    gh.factory<_i45.SelectAndUploadBloc>(
        () => _i45.SelectAndUploadBloc(gh<_i35.SelectAndUploadFile>()));
    gh.factory<_i46.SignUpBloc>(() => _i46.SignUpBloc(
          gh<_i37.SignUp>(),
          gh<_i41.Edit>(),
        ));
    return this;
  }
}

class _$RegisterHttpClient extends _i47.RegisterHttpClient {}

class _$RegisterFToast extends _i47.RegisterFToast {}

class _$RegisterFilePicker extends _i47.RegisterFilePicker {}

class _$RegisterJwtDecoder extends _i47.RegisterJwtDecoder {}

class _$RegisterSharedPref extends _i47.RegisterSharedPref {}
