import 'package:equatable/equatable.dart';

import '../../../cdn/domain/entity/branch_info.dart';
import '../../../cdn/domain/entity/key_value.dart';
import '../../../cdn/domain/entity/upload_file_result.dart';
import 'address_info.dart';
import 'director.dart';
import 'suggested_company.dart';

class SignUpRequestBody extends Equatable {
  final String businessUnitFullName;
  final int nationalId;
  final KeyValue serviceType;
  final List<KeyValue> activityAreas;
  final List<Director> directors;
  final List<UploadFileResult> uploadedDocuments;
  final List<SuggestedCompany> associatedBusinessUnits;
  final BranchInfo suggestedBranch;
  final String telephone;
  final String mobile;
  final String email;
  final String webSite;
  final List<AddressInfo> address;

  const SignUpRequestBody({
    required this.businessUnitFullName,
    required this.nationalId,
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
}
