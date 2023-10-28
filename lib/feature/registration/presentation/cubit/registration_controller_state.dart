part of 'registration_controller_cubit.dart';

class RegistrationControllerState extends Equatable {
  final RegistrationSteps step;
  final RegistrationSteps? errorStep;
  final String companyTitle;
  final String economicId;
  final ActivityType? activityType;
  final List<KeyValue?> activityArea;
  final Director ceoInfo;
  final List<Director> boardMemberInfo;
  final UploadFileResult? statute;
  final UploadFileResult? newspaper;
  final UploadFileResult? balanceSheet;
  final UploadFileResult? profitAndLossStatement;
  final List<UploadFileResult?> otherDocuments;
  final List<SuggestedCompany> suggestedCompanies;
  final BranchInfo? selectedBranch;
  final String mobileNumber;
  final String phoneNumber;
  final String email;
  final String website;
  final String iban;
  // final ProvinceCity? province;
  // final ProvinceCity? city;
  final List<AddressInfo> address;
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
    required this.suggestedCompanies,
    required this.selectedBranch,
    required this.address,
    // required this.city,
    required this.email,
    required this.mobileNumber,
    required this.phoneNumber,
    // required this.province,
    required this.website,
    required this.errorStep,
    required this.iban,
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
        suggestedCompanies,
        selectedBranch,
        address,
        // city,
        iban,
        email,
        mobileNumber,
        phoneNumber,
        // province,
        website,
        errorStep,
      ];

  RegistrationControllerState copyWith({
    RegistrationSteps? step,
    String? companyTitle,
    String? economicId,
    ActivityType? activityType,
    bool? showError,
    List<KeyValue?>? activityArea,
    List<Director>? boardMemberInfo,
    Director? ceoInfo,
    UploadFileResult? statute,
    UploadFileResult? newspaper,
    UploadFileResult? balanceSheet,
    UploadFileResult? profitAndLossStatement,
    List<UploadFileResult?>? otherDocuments,
    List<SuggestedCompany>? suggestedCompanies,
    BranchInfo? selectedBranch,
    String? mobileNumber,
    String? phoneNumber,
    String? email,
    String? website,
    String? iban,
    // ProvinceCity? province,
    List<AddressInfo>? address,
  }) =>
      RegistrationControllerState(
        step: step ?? this.step,
        errorStep: errorStep,
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
        suggestedCompanies: suggestedCompanies ?? this.suggestedCompanies,
        selectedBranch: selectedBranch ?? this.selectedBranch,
        address: address ?? this.address,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        // province: province ?? this.province,
        website: website ?? this.website,
        iban: iban ?? this.iban,
        // city: city,
      );

  // RegistrationControllerState updateCity(ProvinceCity? city) =>
  //     RegistrationControllerState(
  //       step: step,
  //       errorStep: errorStep,
  //       activityType: activityType,
  //       activityArea: activityArea,
  //       companyTitle: companyTitle,
  //       economicId: economicId,
  //       showError: showError,
  //       boardMemberInfo: boardMemberInfo,
  //       ceoInfo: ceoInfo,
  //       balanceSheet: balanceSheet,
  //       newspaper: newspaper,
  //       otherDocuments: otherDocuments,
  //       profitAndLossStatement: profitAndLossStatement,
  //       statute: statute,
  //       suggestedComapnies: suggestedComapnies,
  //       selectedBranch: selectedBranch,
  //       address: address,
  //       city: city,
  //       email: email,
  //       mobileNumber: mobileNumber,
  //       phoneNumber: phoneNumber,
  //       province: province,
  //       website: website,
  //     );

  RegistrationControllerState updateErrorStep(RegistrationSteps? errorStep) =>
      RegistrationControllerState(
        step: step,
        errorStep: errorStep,
        activityType: activityType,
        iban: iban,
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
        suggestedCompanies: suggestedCompanies,
        selectedBranch: selectedBranch,
        address: address,
        // city: city,
        email: email,
        mobileNumber: mobileNumber,
        phoneNumber: phoneNumber,
        // province: province,
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
      case RegistrationSteps.finalize:
        return true;
    }
  }

  RegistrationSteps? get getInvalidStep {
    switch (step) {
      case RegistrationSteps.finalize:
        return null;
      case RegistrationSteps.companyIntroduction:
        return RegistrationSteps.companyIntroduction;
      case RegistrationSteps.managementIntroduction:
        return RegistrationSteps.managementIntroduction;
      case RegistrationSteps.documentsUpload:
        return RegistrationSteps.documentsUpload;
      case RegistrationSteps.suggestedCompany:
        return RegistrationSteps.suggestedCompany;
      case RegistrationSteps.contactInfo:
        return RegistrationSteps.contactInfo;
      case RegistrationSteps.suggestedBranch:
        if (invalidSelectedBranch) return null;
        if (!_isCompanyIntroductionValid) {
          return RegistrationSteps.companyIntroduction;
        }
        if (!_isManagementIntroductionValid) {
          return RegistrationSteps.managementIntroduction;
        }
        if (!_isDocumentsUploadValid) {
          return RegistrationSteps.documentsUpload;
        }
        if (!_isSuggestedCompaniesValid) {
          return RegistrationSteps.suggestedCompany;
        }
        if (!_isContactInfoValid) {
          return RegistrationSteps.contactInfo;
        }
        return RegistrationSteps.suggestedBranch;
    }
  }

  bool get _isCompanyIntroductionValid {
    if (invalidCompanyTitle) return false;
    if (invalidEconomicId) return false;
    if (invalidIban) return false;
    if (invalidActivityType) return false;
    if (invalidActivityArea) return false;
    return true;
  }

  bool get _isManagementIntroductionValid {
    if (invalidCeoName) return false;
    if (invalidCeoNationalCode) return false;
    if (invalidCeoBirthDate) return false;
    if (invalidBoardMemberName) return false;
    if (invalidBoardMemberNationalCode) return false;
    if (invalidBoardMemberBirthDate) return false;
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
    if (!_isCompanyIntroductionValid) return false;
    if (!_isManagementIntroductionValid) return false;
    if (!_isDocumentsUploadValid) return false;
    if (!_isSuggestedCompaniesValid) return false;
    if (!_isContactInfoValid) return false;
    return true;
  }

  bool get invalidCompanyTitle => companyTitle.isEmpty;

  bool get invalidEconomicId => economicId.isEmpty || getEconomicId == null;

  bool get invalidActivityType => activityType == null;

  bool get invalidActivityArea =>
      activityArea.any((element) => element == null);

  bool get canAddMoreArea => activityArea.length < 5;

  bool get invalidCeoName => ceoInfo.invalidName;

  bool get invalidCeoNationalCode => ceoInfo.invalidNationalCode;

  bool get invalidCeoBirthDate => ceoInfo.invalidBirthDate;

  bool get emptyCeoNationalCode => ceoInfo.emptyNationalCode;

  bool get invalidBoardMemberName =>
      boardMemberInfo.any((element) => element.invalidName);

  bool get invalidBoardMemberNationalCode =>
      boardMemberInfo.any((element) => element.invalidNationalCode);

  bool get emptyBoardMemberNationalCode =>
      boardMemberInfo.any((element) => element.emptyNationalCode);

  bool get invalidBoardMemberBirthDate =>
      boardMemberInfo.any((element) => element.invalidBirthDate);

  bool emptyBoardMemberNationalCodeAt(int index) =>
      boardMemberInfo[index].emptyNationalCode;

  bool get canAddMoreBoardMember => boardMemberInfo.length < 20;

  bool get invalidStatute => statute == null;

  bool get invalidNewspaper => newspaper == null;

  bool get invalidBalanceSheet => balanceSheet == null;

  bool get invalidProfitAndLossStatement => profitAndLossStatement == null;

  bool get invalidOtherDocuments =>
      otherDocuments.length > 1 &&
      (otherDocuments.any((element) => element == null) ||
          invalidOtherDocumentsTitle ||
          invalidOtherDocumentsFile);

  bool get invalidOtherDocumentsTitle =>
      otherDocuments.length > 1 &&
      (otherDocuments
          .any((element) => element == null || element.invalidTitle));

  bool get invalidOtherDocumentsFile =>
      otherDocuments.length > 1 &&
      (otherDocuments.any((element) => element == null || element.invalidFile));

  bool get canAddOtherDocuments => otherDocuments.length < 5;

  bool get invalidSuggestedCompaniesName =>
      suggestedCompanies.any((element) => element.invalidName);

  bool get invalidSuggestedCompaniesEconomicId =>
      suggestedCompanies.any((element) => element.invalidEconomicId);

  bool get invalidSuggestedCompaniesFinancialInteraction =>
      suggestedCompanies.any((element) => element.invalidFinancialIteraction);

  bool get canAddSuggestedCompanies => suggestedCompanies.length < 5;

  bool get invalidMobile => !mobileNumber.isValidMobileNumber;

  bool get invalidPhone => phoneNumber.isEmpty;

  bool get invalidEmail => !email.isValidEmail;

  bool get invalidWebsite => !website.isValidWebsite;

  bool get invalidIban {
    if (iban.isEmpty) return false;
    return !iban.isValidIban;
  }

  bool get invalidProvince =>
      address.any((element) => !element.isValidProvince);

  bool get invalidCity => address.any((element) => !element.isValidCity);

  bool get invalidAddress => address.any((element) => !element.isValidAddress);

  bool get canAddAddress => address.length < 5;

  bool get invalidSelectedBranch => selectedBranch == null;

  List<KeyValue> get getActivityArea =>
      activityArea.where((element) => element != null).map((e) => e!).toList();

  List<UploadFileResult> get getOtherDocuments => otherDocuments
      .where((element) => element != null)
      .map((e) => e!)
      .toList();

  int? get getEconomicId => int.tryParse(economicId);

  bool get showMenu => switch (step) {
        RegistrationSteps.finalize => false,
        _ => true,
      };
}
