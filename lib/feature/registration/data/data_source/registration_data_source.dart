import 'package:injectable/injectable.dart';

import '../../../api/manager/api_caller.dart';
import '../../../api/manager/my_client.dart';
import '../../domain/entity/sign_up_response.dart';
import '../model/sign_up_request_body_model.dart';

abstract class RegistrationDataSource {
  /// Request to post registration info as [body].
  /// Call a [POST] request to the http://.... endpoint.
  ///
  Future<SignUpResponse> signUp(SignUpRequestBodyModel body);
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
  Future<SignUpResponse> signUp(SignUpRequestBodyModel body) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return const SignUpResponse(trackingId: '1758735693');
  }
}
