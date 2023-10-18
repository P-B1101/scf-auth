import '../../domain/entity/sign_up_response.dart';

class SignUpResponseModel extends SignUpResponse {
  const SignUpResponseModel({
    required super.trackingId,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      SignUpResponseModel(
        trackingId: json['referenceCode'],
      );
}
