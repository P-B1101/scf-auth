import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../api/manager/api_caller.dart';
import '../../../api/manager/my_client.dart';
import '../../../env/env_manager.dart';
import '../../domain/entity/sign_up_response.dart';
import '../model/sign_up_request_body_model.dart';
import '../model/sign_up_response_model.dart';

abstract class RegistrationDataSource {
  /// Request to post registration info as [body].
  /// Call a [POST] request to the http://.... endpoint.
  ///
  Future<SignUpResponse> signUp({
    required SignUpRequestBodyModel body,
    required String token,
  });

  Future<String> sendOtp(String phoneNumber);

  Future<String> resendOtp(String otpToken);

  Future<String> validateOtp({
    required String otpToken,
    required String code,
  });
}

@LazySingleton(as: RegistrationDataSource)
class RegistrationDataSourceImpl implements RegistrationDataSource {
  final MyClient client;
  final ApiCaller apiCaller;
  const RegistrationDataSourceImpl({
    required this.apiCaller,
    required this.client,
  });

  @override
  Future<SignUpResponse> signUp({
    required SignUpRequestBodyModel body,
    required String token,
  }) =>
      apiCaller.callApi(
        converter: (body) => SignUpResponseModel.fromJson(body),
        request: () => client.post(
          EnvManager.getUri(path: 'scf-registration/info-registration'),
          body: json.encode(body.toJson),
          encoding: Encoding.getByName('utf-8'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );
  @override
  Future<String> sendOtp(String phoneNumber) async {
    final body = {
      'mobileNumber': phoneNumber,
      'targetPlatformType': Utils.targetPlatformType.toValue,
    };
    return apiCaller.callApi(
      converter: (body) => body['otpToken'],
      request: () => client.post(
        EnvManager.getUri(
          path: 'scf-registration/public/mobile-registration',
        ),
        body: json.encode(body),
        encoding: Encoding.getByName('utf-8'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      ),
    );
  }

  @override
  Future<String> validateOtp({
    required String otpToken,
    required String code,
  }) async {
    final body = {
      'otpToken': otpToken,
      'code': code,
    };
    return apiCaller.callApi(
      converter: (body) => body['accessToken'],
      request: () => client.post(
        EnvManager.getUri(
          path: 'scf-registration/public/mobile-registration/verify',
        ),
        body: json.encode(body),
        encoding: Encoding.getByName('utf-8'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      ),
    );
  }

  @override
  Future<String> resendOtp(String otpToken) async {
    final body = {'otpToken': otpToken};
    return apiCaller.callApi(
      converter: (body) => body['otpToken'],
      request: () => client.post(
        EnvManager.getUri(
          path: 'scf-registration/public/mobile-registration/resend',
        ),
        body: json.encode(body),
        encoding: Encoding.getByName('utf-8'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      ),
    );
  }
}
