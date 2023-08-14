import 'package:scf_auth/feature/cdn/data/model/key_value_model.dart';

import '../../../cdn/data/model/branch_info_model.dart';
import '../../../cdn/data/model/uploaded_file_result_model.dart';
import '../../domain/entity/sign_up_request_body.dart';
import 'address_info_model.dart';
import 'director_model.dart';
import 'suggested_company_model.dart';

class SignUpRequestBodyModel extends SignUpRequestBody {
  const SignUpRequestBodyModel({
    required super.address,
    required super.documents,
    required super.economicNationalId,
    required super.email,
    required super.enterpriseFullName,
    required super.industries,
    required super.mobile,
    required super.partners,
    required super.people,
    required super.serviceType,
    required super.suggestedBranch,
    required super.telephone,
    required super.webSite,
  });

  factory SignUpRequestBodyModel.fromEntity(SignUpRequestBody entity) =>
      SignUpRequestBodyModel(
        address: entity.address,
        documents: entity.documents,
        economicNationalId: entity.economicNationalId,
        email: entity.email,
        enterpriseFullName: entity.enterpriseFullName,
        industries: entity.industries,
        mobile: entity.mobile,
        partners: entity.partners,
        people: entity.people,
        serviceType: entity.serviceType,
        suggestedBranch: entity.suggestedBranch,
        telephone: entity.telephone,
        webSite: entity.webSite,
      );

  Map<String, dynamic> get toJson => {
        'enterpriseFullName': enterpriseFullName,
        'economicNationalId': economicNationalId,
        'serviceType': serviceType.id,
        'industries':
            industries.map((e) => KeyValueModel.fromEntity(e).toJson).toList(),
        'people':
            people.map((e) => DirectorModel.fromEntity(e).toJson).toList(),
        'documents': documents
            .map((e) => UploadFileResultModel.fromEntity(e).toJson)
            .toList(),
        'partners': partners
            .map((e) => SuggestedCompanyModel.fromEntity(e).toJson)
            .toList(),
        'suggestedBranch': BranchInfoModel.fromEntity(suggestedBranch).toJson,
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
