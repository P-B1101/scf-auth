import '../../../cdn/data/model/key_value_model.dart';
import '../../../cdn/data/model/uploaded_file_result_model.dart';
import '../../domain/entity/sign_up_request_body.dart';
import 'address_info_model.dart';
import 'director_model.dart';
import 'suggested_company_model.dart';

class SignUpRequestBodyModel extends SignUpRequestBody {
  const SignUpRequestBodyModel({
    required super.address,
    required super.uploadedDocuments,
    required super.nationalId,
    required super.email,
    required super.businessUnitFullName,
    required super.activityAreas,
    required super.mobile,
    required super.associatedBusinessUnits,
    required super.directors,
    required super.serviceType,
    required super.suggestedBranch,
    required super.telephone,
    required super.webSite,
  });

  factory SignUpRequestBodyModel.fromEntity(SignUpRequestBody entity) =>
      SignUpRequestBodyModel(
        address: entity.address,
        uploadedDocuments: entity.uploadedDocuments,
        nationalId: entity.nationalId,
        email: entity.email,
        businessUnitFullName: entity.businessUnitFullName,
        activityAreas: entity.activityAreas,
        mobile: entity.mobile,
        associatedBusinessUnits: entity.associatedBusinessUnits,
        directors: entity.directors,
        serviceType: entity.serviceType,
        suggestedBranch: entity.suggestedBranch,
        telephone: entity.telephone,
        webSite: entity.webSite,
      );

  Map<String, dynamic> get toJson => {
        'businessUnitFullName': businessUnitFullName,
        'nationalId': nationalId,
        'activityType': serviceType.id,
        'activityAreas': activityAreas
            .map((e) => KeyValueModel.fromEntity(e).toJson)
            .toList(),
        'directors':
            directors.map((e) => DirectorModel.fromEntity(e).toJson).toList(),
        'uploadedDocuments': uploadedDocuments
            .map((e) => UploadFileResultModel.fromEntity(e).toJson)
            .toList(),
        'associatedBusinessUnits': associatedBusinessUnits
            .map((e) => SuggestedCompanyModel.fromEntity(e).toJson)
            .toList(),
        'suggestedBranchId': suggestedBranch.id,
        'contact': {
          'telephone': telephone,
          'mobile': mobile,
          'email': email,
          'webSite': webSite,
          'address': address
              .map((e) => AddressInfoModel.fromEntity(e).toJson)
              .toList(),
        }
      };
}
