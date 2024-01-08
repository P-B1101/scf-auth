import 'package:scf_auth/core/utils/extensions.dart';
import 'package:scf_auth/feature/cdn/domain/entity/branch_info.dart';
import 'package:scf_auth/feature/cdn/domain/entity/key_value.dart';
import 'package:scf_auth/feature/cdn/domain/entity/upload_file_result.dart';
import 'package:scf_auth/feature/registration/domain/entity/address_info.dart';
import 'package:scf_auth/feature/registration/domain/entity/director.dart';
import 'package:scf_auth/feature/registration/domain/entity/suggested_company.dart';

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
    required super.iban,
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
        iban: entity.iban,
      );

  factory SignUpRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      SignUpRequestBodyModel(
        activityAreas: () {
          final value = json['activityAreas'];
          if (value is! List) return <KeyValue>[];
          return value.map((e) => KeyValueModel.fromJson(e)).toList();
        }(),
        address: () {
          final value = json['contact']?['address'];
          if (value is! List) return <AddressInfo>[];
          return value.map((e) => AddressInfoModel.fromJson(e)).toList();
        }(),
        iban: json['iban'] ?? '',
        associatedBusinessUnits: () {
          final value = json['associatedBusinessUnits'];
          if (value is! List) return <SuggestedCompany>[];
          return value.map((e) => SuggestedCompanyModel.fromJson(e)).toList();
        }(),
        businessUnitFullName: json['businessUnitFullName'],
        directors: () {
          final value = json['directors'];
          if (value is! List) return <Director>[];
          return value.map((e) => DirectorModel.fromJson(e)).toList();
        }(),
        email: json['contact']?['email'],
        mobile: json['contact']?['mobile'],
        nationalId: json['nationalId'],
        serviceType: () {
          final value = json['activityType'];
          if (value is! String) return null;
          return value.toActivityType;
        }(),
        suggestedBranch: () {
          final value = json['selectedBranchCode'];
          if (value == null) return null;
          return BranchInfo(
            id: value,
            title: value,
            lat: null,
            lng: null,
          );
        }(),
        telephone: json['contact']?['telephone'],
        uploadedDocuments: () {
          final value = json['uploadedDocuments'];
          if (value is! List) return <UploadFileResult>[];
          return value.map((e) => UploadFileResultModel.fromJson(e)).toList();
        }(),
        webSite: json['contact']?['webSite'],
      );

  Map<String, dynamic> get toJson => {
        'businessUnitFullName': businessUnitFullName,
        'nationalId': nationalId,
        'activityType': serviceType?.toValue,
        'iban': iban.isEmpty ? null : iban,
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
        'selectedBranchCode': suggestedBranch?.id,
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
