import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../cdn/domain/entity/branch_info.dart';
import '../../../cdn/domain/entity/key_value.dart';
import '../../../cdn/domain/entity/province_city.dart';
import '../../../cdn/domain/entity/upload_file_result.dart';
import '../../domain/entity/name_national_code.dart';
import '../../domain/entity/suggested_company.dart';

part 'registration_controller_state.dart';

@injectable
class RegistrationControllerCubit extends Cubit<RegistrationControllerState> {
  RegistrationControllerCubit()
      : super(RegistrationControllerState(
          step: RegistrationSteps.companyIntroduction,
          activityType: null,
          activityArea: const [null],
          companyTitle: '',
          economicId: '',
          showError: false,
          boardMemberInfo: [NameNationalCode.init()],
          ceoInfo: NameNationalCode.init(),
          balanceSheet: null,
          newspaper: null,
          otherDocuments: const [null],
          profitAndLossStatement: null,
          statute: null,
          suggestedComapnies: [SuggestedCompany.init()],
          selectedBranch: null,
          address: const [''],
          city: null,
          email: '',
          mobileNumber: '',
          phoneNumber: '',
          province: null,
          website: '',
        ));

  void onPageClick(RegistrationSteps step) => emit(state.copyWith(step: step));

  void updateCompanyTitle(String companyTitle) =>
      emit(state.copyWith(companyTitle: companyTitle));

  void updateEconomicId(String economicId) =>
      emit(state.copyWith(economicId: economicId));

  RegistrationControllerState? onNextClick() {
    if (!state.isEnable) {
      emit(state.copyWith(showError: true));
      return null;
    }
    final RegistrationControllerState newState;
    switch (state.step) {
      case RegistrationSteps.companyIntroduction:
        newState = state.copyWith(
          showError: false,
          step: RegistrationSteps.managementIntroduction,
        );
        break;
      case RegistrationSteps.managementIntroduction:
        newState = state.copyWith(
          showError: false,
          step: RegistrationSteps.documentsUpload,
        );
        break;
      case RegistrationSteps.documentsUpload:
        newState = state.copyWith(
          showError: false,
          step: RegistrationSteps.suggestedCompany,
        );
        break;
      case RegistrationSteps.suggestedCompany:
        newState = state.copyWith(
          showError: false,
          step: RegistrationSteps.contactInfo,
        );
        break;
      case RegistrationSteps.contactInfo:
        newState = state.copyWith(
          showError: false,
          step: RegistrationSteps.suggestedBranch,
        );
        break;
      case RegistrationSteps.suggestedBranch:
        newState = state.copyWith(showError: false);
        break;
    }
    emit(newState);
    return newState;
  }

  RegistrationControllerState? onBackClick() {
    final RegistrationControllerState newState;
    switch (state.step) {
      case RegistrationSteps.companyIntroduction:
        return null;
      case RegistrationSteps.managementIntroduction:
        newState = state.copyWith(step: RegistrationSteps.companyIntroduction);
        break;
      case RegistrationSteps.documentsUpload:
        newState =
            state.copyWith(step: RegistrationSteps.managementIntroduction);
        break;
      case RegistrationSteps.suggestedCompany:
        newState = state.copyWith(step: RegistrationSteps.documentsUpload);
        break;
      case RegistrationSteps.contactInfo:
        newState = state.copyWith(step: RegistrationSteps.suggestedCompany);
        break;
      case RegistrationSteps.suggestedBranch:
        newState = state.copyWith(step: RegistrationSteps.contactInfo);
        break;
    }
    emit(newState);
    return newState;
  }

  void updateActivityAreaAt({
    required KeyValue item,
    required int index,
  }) {
    final newItems = state.activityArea.updateItemAt(index, item);
    emit(state.copyWith(activityArea: newItems));
  }

  void updateActivityType(KeyValue item) =>
      emit(state.copyWith(activityType: item));

  void addActivityArea() {
    final newItems = [...state.activityArea, null];
    emit(state.copyWith(activityArea: newItems));
  }

  void addBoardMemberInfo() {
    final newItems = [...state.boardMemberInfo, NameNationalCode.init()];
    emit(state.copyWith(boardMemberInfo: newItems));
  }

  void deleteActivityArea(int index) {
    final newItems = state.activityArea.deleteItemAt(index);
    emit(state.copyWith(activityArea: newItems));
  }

  void deleteBoardMemberInfo(int index) {
    final newItems = state.boardMemberInfo.deleteItemAt(index);
    emit(state.copyWith(boardMemberInfo: newItems));
  }

  void updateCeoName(String name) =>
      emit(state.copyWith(ceoInfo: state.ceoInfo.copyWith(name: name)));

  void updateCeoNationalCode(String nationalCode) => emit(state.copyWith(
        ceoInfo: state.ceoInfo.copyWith(nationalCode: nationalCode),
      ));

  void updateBoardMemberNameAt(int index, String name) {
    final newItems = state.boardMemberInfo.updateNameAt(index, name);
    emit(state.copyWith(boardMemberInfo: newItems));
  }

  void updateBoardMemberNationalCodeAt(int index, String nationalCode) {
    final newItems =
        state.boardMemberInfo.updateNationalCodeAt(index, nationalCode);
    emit(state.copyWith(boardMemberInfo: newItems));
  }

  void updateStatute(UploadFileResult result) =>
      emit(state.copyWith(statute: result));

  void updateNewspaper(UploadFileResult result) =>
      emit(state.copyWith(newspaper: result));

  void updateBalanceSheet(UploadFileResult result) =>
      emit(state.copyWith(balanceSheet: result));

  void updateProfitAndLossStatement(UploadFileResult result) =>
      emit(state.copyWith(profitAndLossStatement: result));

  void updateOtherDocumentsAt(int index, UploadFileResult result) {
    final newItems = state.otherDocuments.updateItemAt(index, result);
    emit(state.copyWith(otherDocuments: newItems));
  }

  void updateOtherDocumentsTitleAt(int index, String title) {
    final newItems = state.otherDocuments.updateTitleAt(index, title);
    emit(state.copyWith(otherDocuments: newItems));
  }

  void addOtherDocuments() {
    final newItems = [...state.otherDocuments, null];
    emit(state.copyWith(otherDocuments: newItems));
  }

  void deleteOtherDocument(int index) {
    final newItems = state.otherDocuments.deleteItemAt(index);
    emit(state.copyWith(otherDocuments: newItems));
  }

  void addSuggestedCompany() {
    final newItems = [...state.suggestedComapnies, SuggestedCompany.init()];
    emit(state.copyWith(suggestedComapnies: newItems));
  }

  void deleteSuggestedCompany(int index) {
    final newItems = state.suggestedComapnies.deleteItemAt(index);
    emit(state.copyWith(suggestedComapnies: newItems));
  }

  void updateSuggestedCompanyNameAt(int index, String title) {
    final newItems = state.suggestedComapnies.updateNameAt(index, title);
    emit(state.copyWith(suggestedComapnies: newItems));
  }

  void updateSuggestedCompanyEconomicIdAt(int index, String economicId) {
    final newItems =
        state.suggestedComapnies.updateEconomicIdAt(index, economicId);
    emit(state.copyWith(suggestedComapnies: newItems));
  }

  void updateSuggestedCompanyFinancialInteractionAt(
      int index, int? financialInteraction) {
    final newItems = state.suggestedComapnies
        .updateFinancialInteractionAt(index, financialInteraction);
    emit(state.copyWith(suggestedComapnies: newItems));
  }

  void updateSelectedBranch(BranchInfo selectedBranch) =>
      emit(state.copyWith(selectedBranch: selectedBranch));

  void addAddress() {
    final newItems = [...state.address, ''];
    emit(state.copyWith(address: newItems));
  }

  void updateMobile(String mobile) =>
      emit(state.copyWith(mobileNumber: mobile));

  void updatePhone(String phoneNumber) =>
      emit(state.copyWith(phoneNumber: phoneNumber));

  void updateEmail(String email) => emit(state.copyWith(email: email));

  void updateWebsite(String website) => emit(state.copyWith(website: website));

  void updateProvince(ProvinceCity province) {
    final oldProvince = state.province;
    if (province == oldProvince) return;
    final newState = state.copyWith(province: province).updateCity(null);
    emit(newState);
  }

  void updateCity(ProvinceCity? city) => emit(state.updateCity(city));

  void updateAddressAt(int index, String address) {
    final newItems = state.address.updateItemAt(index, address);
    emit(state.copyWith(address: newItems));
  }

  void deleteAddress(int index) {
    final newItems = state.address.deleteItemAt(index);
    emit(state.copyWith(address: newItems));
  }
}
