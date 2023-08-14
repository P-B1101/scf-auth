import 'package:scf_auth/feature/registration/domain/entity/sign_up_request_body.dart';

class SignUpRequestBodyModel extends SignUpRequestBody {
  const SignUpRequestBodyModel();

  factory SignUpRequestBodyModel.fromEntity(SignUpRequestBody entity) =>
      const SignUpRequestBodyModel();

  Map<String, dynamic> get toJson => {};
}
