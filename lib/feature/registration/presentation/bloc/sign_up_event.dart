part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SubmitSignUpEvent extends SignUpEvent {
  final String companyTitle;
  final String economicId;
  final ActivityType activityType;
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
  // final ProvinceCity province;
  // final ProvinceCity city;
  final List<AddressInfo> address;
  final String iban;
  final bool isEdit;

  const SubmitSignUpEvent({
    required this.activityArea,
    required this.activityType,
    required this.address,
    required this.balanceSheet,
    required this.boardMemberInfo,
    required this.ceoInfo,
    // required this.city,
    required this.companyTitle,
    required this.economicId,
    required this.email,
    required this.mobileNumber,
    required this.newspaper,
    required this.otherDocuments,
    required this.phoneNumber,
    required this.profitAndLossStatement,
    // required this.province,
    required this.selectedBranch,
    required this.statute,
    required this.suggestedComapnies,
    required this.website,
    required this.iban,
    required this.isEdit,
  });

  @override
  List<Object> get props => [
        activityArea,
        activityType,
        address,
        balanceSheet,
        boardMemberInfo,
        ceoInfo,
        // city,
        companyTitle,
        economicId,
        email,
        mobileNumber,
        newspaper,
        otherDocuments,
        phoneNumber,
        profitAndLossStatement,
        // province,
        selectedBranch,
        statute,
        suggestedComapnies,
        website,
        iban,
        isEdit,
      ];

  factory SubmitSignUpEvent.signUp({
    required String companyTitle,
    required String economicId,
    required ActivityType activityType,
    required List<KeyValue> activityArea,
    required Director ceoInfo,
    required List<Director> boardMemberInfo,
    required UploadFileResult statute,
    required UploadFileResult newspaper,
    required UploadFileResult balanceSheet,
    required UploadFileResult profitAndLossStatement,
    required List<UploadFileResult> otherDocuments,
    required List<SuggestedCompany> suggestedComapnies,
    required BranchInfo selectedBranch,
    required String mobileNumber,
    required String phoneNumber,
    required String email,
    required String website,
    required List<AddressInfo> address,
    required String iban,
  }) =>
      SubmitSignUpEvent(
        activityArea: activityArea,
        activityType: activityType,
        address: address,
        balanceSheet: balanceSheet,
        boardMemberInfo: boardMemberInfo,
        ceoInfo: ceoInfo,
        companyTitle: companyTitle,
        economicId: economicId,
        email: email,
        mobileNumber: mobileNumber,
        newspaper: newspaper,
        otherDocuments: otherDocuments,
        phoneNumber: phoneNumber,
        profitAndLossStatement: profitAndLossStatement,
        selectedBranch: selectedBranch,
        statute: statute,
        suggestedComapnies: suggestedComapnies,
        website: website,
        iban: iban,
        isEdit: false,
      );

  factory SubmitSignUpEvent.edit({
    required String companyTitle,
    required String economicId,
    required ActivityType activityType,
    required List<KeyValue> activityArea,
    required Director ceoInfo,
    required List<Director> boardMemberInfo,
    required UploadFileResult statute,
    required UploadFileResult newspaper,
    required UploadFileResult balanceSheet,
    required UploadFileResult profitAndLossStatement,
    required List<UploadFileResult> otherDocuments,
    required List<SuggestedCompany> suggestedComapnies,
    required BranchInfo selectedBranch,
    required String mobileNumber,
    required String phoneNumber,
    required String email,
    required String website,
    required List<AddressInfo> address,
    required String iban,
  }) =>
      SubmitSignUpEvent(
        activityArea: activityArea,
        activityType: activityType,
        address: address,
        balanceSheet: balanceSheet,
        boardMemberInfo: boardMemberInfo,
        ceoInfo: ceoInfo,
        companyTitle: companyTitle,
        economicId: economicId,
        email: email,
        mobileNumber: mobileNumber,
        newspaper: newspaper,
        otherDocuments: otherDocuments,
        phoneNumber: phoneNumber,
        profitAndLossStatement: profitAndLossStatement,
        selectedBranch: selectedBranch,
        statute: statute,
        suggestedComapnies: suggestedComapnies,
        website: website,
        iban: iban,
        isEdit: true,
      );
}
