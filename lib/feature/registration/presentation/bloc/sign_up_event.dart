part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SubmitSignUpEvent extends SignUpEvent {
  final String companyTitle;
  final int economicId;
  final KeyValue activityType;
  final List<KeyValue> activityArea;
  final Director ceoInfo;
  final List<Director> boardMemberInfo;
  final UploadFileResult statute;
  final UploadFileResult newspaper;
  final UploadFileResult balanceSheet;
  final UploadFileResult profitAndLossStatement;
  final List<UploadFileResult> otherDocuments;
  final List<SuggestedCompany> suggestedComapnies;
  final BranchInfo selectedBranch;
  final String mobileNumber;
  final String phoneNumber;
  final String email;
  final String website;
  final ProvinceCity province;
  final ProvinceCity city;
  final List<AddressInfo> address;


  const SubmitSignUpEvent({
    required this.activityArea,
    required this.activityType,
    required this.address,
    required this.balanceSheet,
    required this.boardMemberInfo,
    required this.ceoInfo ,
    required this.city,
    required this.companyTitle,
    required this.economicId,
    required this.email,
    required this.mobileNumber,
    required this.newspaper,
    required this.otherDocuments,
    required this.phoneNumber,
    required this.profitAndLossStatement,
    required this.province,
    required this.selectedBranch,
    required this.statute,
    required this.suggestedComapnies,
    required this.website,
  });


  @override
  List<Object> get props => [
    activityArea,
    activityType,
    address,
    balanceSheet,
    boardMemberInfo,
    ceoInfo ,
    city,
    companyTitle,
    economicId,
    email,
    mobileNumber,
    newspaper,
    otherDocuments,
    phoneNumber,
    profitAndLossStatement,
    province,
    selectedBranch,
    statute,
    suggestedComapnies,
    website,
  ];
}
