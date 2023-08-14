import 'package:equatable/equatable.dart';

import '../../../cdn/domain/entity/branch_info.dart';
import '../../../cdn/domain/entity/key_value.dart';
import '../../../cdn/domain/entity/upload_file_result.dart';
import 'address_info.dart';
import 'director.dart';
import 'suggested_company.dart';

class SignUpRequestBody extends Equatable {
  final String enterpriseFullName;
  final int economicNationalId;
  final KeyValue serviceType;
  final List<KeyValue> industries;
  final List<Director> people;
  final List<UploadFileResult> documents;
  final List<SuggestedCompany> partners;
  final BranchInfo suggestedBranch;
  final String telephone;
  final String mobile;
  final String email;
  final String webSite;
  final List<AddressInfo> address;

  const SignUpRequestBody({
    required this.enterpriseFullName,
    required this.economicNationalId,
    required this.serviceType,
    required this.industries,
    required this.people,
    required this.documents,
    required this.partners,
    required this.suggestedBranch,
    required this.telephone,
    required this.mobile,
    required this.email,
    required this.webSite,
    required this.address,
  });

  @override
  List<Object?> get props => [
        enterpriseFullName,
        economicNationalId,
        serviceType,
        industries,
        people,
        documents,
        partners,
        suggestedBranch,
        telephone,
        mobile,
        email,
        webSite,
        address,
      ];
}
