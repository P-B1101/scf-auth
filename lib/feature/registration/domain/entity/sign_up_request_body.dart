import 'package:equatable/equatable.dart';
import 'package:scf_auth/core/utils/enums.dart';

import '../../../cdn/domain/entity/branch_info.dart';
import '../../../cdn/domain/entity/key_value.dart';
import '../../../cdn/domain/entity/upload_file_result.dart';
import 'address_info.dart';
import 'director.dart';
import 'suggested_company.dart';

class SignUpRequestBody extends Equatable {
  final String businessUnitFullName;
  final String nationalId;
  final String iban;
  final ActivityType? serviceType;
  final List<KeyValue> activityAreas;
  final List<Director> directors;
  final List<UploadFileResult> uploadedDocuments;
  final List<SuggestedCompany> associatedBusinessUnits;
  final BranchInfo? suggestedBranch;
  final String telephone;
  final String mobile;
  final String email;
  final String webSite;
  final List<AddressInfo> address;

  const SignUpRequestBody({
    required this.businessUnitFullName,
    required this.nationalId,
    required this.iban,
    required this.serviceType,
    required this.activityAreas,
    required this.directors,
    required this.uploadedDocuments,
    required this.associatedBusinessUnits,
    required this.suggestedBranch,
    required this.telephone,
    required this.mobile,
    required this.email,
    required this.webSite,
    required this.address,
  });

  @override
  List<Object?> get props => [
        businessUnitFullName,
        nationalId,
        iban,
        serviceType,
        activityAreas,
        directors,
        uploadedDocuments,
        associatedBusinessUnits,
        suggestedBranch,
        telephone,
        mobile,
        email,
        webSite,
        address,
      ];

  SignUpRequestBody copyWith({
    BranchInfo? suggestedBranch,
  }) =>
      SignUpRequestBody(
        businessUnitFullName: businessUnitFullName,
        nationalId: nationalId,
        serviceType: serviceType,
        activityAreas: activityAreas,
        directors: directors,
        uploadedDocuments: uploadedDocuments,
        associatedBusinessUnits: associatedBusinessUnits,
        suggestedBranch: suggestedBranch ?? this.suggestedBranch,
        telephone: telephone,
        mobile: mobile,
        email: email,
        webSite: webSite,
        address: address,
        iban: iban,
      );
}
