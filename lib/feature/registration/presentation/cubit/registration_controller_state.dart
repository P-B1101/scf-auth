part of 'registration_controller_cubit.dart';

class RegistrationControllerState extends Equatable {
  final RegistrationSteps step;
  final String companyTitle;
  final String economicId;
  final KeyValue? activityType;
  final List<KeyValue?> activityArea;
  final NameNationalCode ceoInfo;
  final List<NameNationalCode> boardMemberInfo;
  final UploadFileResult? statute;
  final UploadFileResult? newspaper;
  final UploadFileResult? balanceSheet;
  final UploadFileResult? profitAndLossStatement;
  final List<UploadFileResult?> otherDocuments;
  final List<SuggestedCompany> suggestedComapnies;
  final BranchInfo? selectedBranch;
  final String mobileNumber;
  final String phoneNumber;
  final String email;
  final String website;
  final ProvinceCity? province;
  final ProvinceCity? city;
  final List<String> address;
  final bool showError;

  const RegistrationControllerState({
    required this.step,
    required this.activityType,
    required this.activityArea,
    required this.companyTitle,
    required this.economicId,
    required this.showError,
    required this.boardMemberInfo,
    required this.ceoInfo,
    required this.balanceSheet,
    required this.newspaper,
    required this.otherDocuments,
    required this.profitAndLossStatement,
    required this.statute,
    required this.suggestedComapnies,
    required this.selectedBranch,
    required this.address,
    required this.city,
    required this.email,
    required this.mobileNumber,
    required this.phoneNumber,
    required this.province,
    required this.website,
  });

  @override
  List<Object?> get props => [
        step,
        activityType,
        activityArea,
        companyTitle,
        economicId,
        showError,
        boardMemberInfo,
        ceoInfo,
        balanceSheet,
        newspaper,
        otherDocuments,
        profitAndLossStatement,
        statute,
        suggestedComapnies,
        selectedBranch,
        address,
        city,
        email,
        mobileNumber,
        phoneNumber,
        province,
        website,
      ];

  RegistrationControllerState copyWith({
    RegistrationSteps? step,
    String? companyTitle,
    String? economicId,
    KeyValue? activityType,
    bool? showError,
    List<KeyValue?>? activityArea,
    List<NameNationalCode>? boardMemberInfo,
    NameNationalCode? ceoInfo,
    UploadFileResult? statute,
    UploadFileResult? newspaper,
    UploadFileResult? balanceSheet,
    UploadFileResult? profitAndLossStatement,
    List<UploadFileResult?>? otherDocuments,
    List<SuggestedCompany>? suggestedComapnies,
    BranchInfo? selectedBranch,
    String? mobileNumber,
    String? phoneNumber,
    String? email,
    String? website,
    ProvinceCity? province,
    List<String>? address,
  }) =>
      RegistrationControllerState(
        step: step ?? this.step,
        activityType: activityType ?? this.activityType,
        companyTitle: companyTitle ?? this.companyTitle,
        economicId: economicId ?? this.economicId,
        showError: showError ?? this.showError,
        activityArea: activityArea ?? this.activityArea,
        boardMemberInfo: boardMemberInfo ?? this.boardMemberInfo,
        ceoInfo: ceoInfo ?? this.ceoInfo,
        balanceSheet: balanceSheet ?? this.balanceSheet,
        newspaper: newspaper ?? this.newspaper,
        otherDocuments: otherDocuments ?? this.otherDocuments,
        profitAndLossStatement:
            profitAndLossStatement ?? this.profitAndLossStatement,
        statute: statute ?? this.statute,
        suggestedComapnies: suggestedComapnies ?? this.suggestedComapnies,
        selectedBranch: selectedBranch ?? this.selectedBranch,
        address: address ?? this.address,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        province: province ?? this.province,
        website: website ?? this.website,
        city: city,
      );

  RegistrationControllerState updateCity(ProvinceCity? city) =>
      RegistrationControllerState(
        step: step,
        activityType: activityType,
        activityArea: activityArea,
        companyTitle: companyTitle,
        economicId: economicId,
        showError: showError,
        boardMemberInfo: boardMemberInfo,
        ceoInfo: ceoInfo,
        balanceSheet: balanceSheet,
        newspaper: newspaper,
        otherDocuments: otherDocuments,
        profitAndLossStatement: profitAndLossStatement,
        statute: statute,
        suggestedComapnies: suggestedComapnies,
        selectedBranch: selectedBranch,
        address: address,
        city: city,
        email: email,
        mobileNumber: mobileNumber,
        phoneNumber: phoneNumber,
        province: province,
        website: website,
      );

  bool get isEnable {
    switch (step) {
      case RegistrationSteps.companyIntroduction:
        return _isCompanyIntroductionValid;
      case RegistrationSteps.managementIntroduction:
        return _isManagementIntroductionValid;
      case RegistrationSteps.documentsUpload:
        return _isDocumentsUploadValid;
      case RegistrationSteps.suggestedCompany:
        return _isSuggestedCompaniesValid;
      case RegistrationSteps.contactInfo:
        return _isContactInfoValid;
      case RegistrationSteps.suggestedBranch:
        return _isSuggestedBranchValid;
    }
  }

  bool get _isCompanyIntroductionValid {
    if (invalidCompanyTitle) return false;
    if (invalidEconomicId) return false;
    if (invalidActivityType) return false;
    if (invalidActivityArea) return false;
    return true;
  }

  bool get _isManagementIntroductionValid {
    if (invalidCeoName) return false;
    if (invalidCeoNationalCode) return false;
    if (invalidBoardMemeberName) return false;
    if (invalidBoardMemeberNationalCode) return false;
    return true;
  }

  bool get _isDocumentsUploadValid {
    if (invalidStatute) return false;
    if (invalidNewspaper) return false;
    if (invalidBalanceSheet) return false;
    if (invalidProfitAndLossStatement) return false;
    if (invalidOtherDocuments) return false;
    return true;
  }

  bool get _isSuggestedCompaniesValid {
    if (invalidSuggestedCompaniesName) return false;
    if (invalidSuggestedCompaniesEconomicId) return false;
    if (invalidSuggestedCompaniesFinancialInteraction) return false;
    return true;
  }

  bool get _isContactInfoValid {
    if (invalidMobile) return false;
    if (invalidPhone) return false;
    if (invalidEmail) return false;
    if (invalidWebsite) return false;
    if (invalidProvince) return false;
    if (invalidCity) return false;
    if (invalidAddress) return false;
    return true;
  }

  bool get _isSuggestedBranchValid {
    if (invalidSelectedBranch) return false;
    return true;
  }

  bool get invalidCompanyTitle => companyTitle.isEmpty;

  bool get invalidEconomicId => economicId.isEmpty;

  bool get invalidActivityType => activityType == null;

  bool get invalidActivityArea =>
      activityArea.any((element) => element == null);

  bool get canAddMoreArea => activityArea.length < 5;

  bool get invalidCeoName => ceoInfo.invalidName;

  bool get invalidCeoNationalCode => ceoInfo.invalidNationalCode;

  bool get emptyCeoNationalCode => ceoInfo.emptyNationalCode;

  bool get invalidBoardMemeberName =>
      boardMemberInfo.any((element) => element.invalidName);

  bool get invalidBoardMemeberNationalCode =>
      boardMemberInfo.any((element) => element.invalidNationalCode);

  bool get emptyBoardMemeberNationalCode =>
      boardMemberInfo.any((element) => element.emptyNationalCode);

  bool emptyBoardMemeberNationalCodeAt(int index) =>
      boardMemberInfo[index].emptyNationalCode;

  bool get canAddMoreBoardMember => boardMemberInfo.length < 20;

  bool get invalidStatute => statute == null;

  bool get invalidNewspaper => newspaper == null;

  bool get invalidBalanceSheet => balanceSheet == null;

  bool get invalidProfitAndLossStatement => profitAndLossStatement == null;

  bool get invalidOtherDocuments =>
      otherDocuments.any((element) => element == null) ||
      invalidOtherDocumentsTitle ||
      invalidOtherDocumentsFile;

  bool get invalidOtherDocumentsTitle =>
      otherDocuments.any((element) => element == null || element.invalidTitle);

  bool get invalidOtherDocumentsFile =>
      otherDocuments.any((element) => element == null || element.invalidFile);

  bool get canAddOtherDocuments => otherDocuments.length < 5;

  bool get invalidSuggestedCompaniesName =>
      suggestedComapnies.any((element) => element.invalidName);

  bool get invalidSuggestedCompaniesEconomicId =>
      suggestedComapnies.any((element) => element.invalidEconomicId);

  bool get invalidSuggestedCompaniesFinancialInteraction =>
      suggestedComapnies.any((element) => element.invalidFinancialIteraction);

  bool get canAddSuggestedCompanies => suggestedComapnies.length < 5;

  bool get invalidMobile => !mobileNumber.isValidMobileNumber;

  bool get invalidPhone => phoneNumber.isEmpty;

  bool get invalidEmail => !email.isValidEmail;

  bool get invalidWebsite => !website.isValidWebsite;

  bool get invalidProvince => province == null;

  bool get invalidCity => city == null;

  bool get invalidAddress => address.any((element) => element.isEmpty);

  bool get canAddAddress => address.length < 5;

  bool get invalidSelectedBranch => selectedBranch == null;
}
