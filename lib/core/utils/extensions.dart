import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:scf_auth/feature/cdn/domain/entity/upload_file_result.dart';
import 'package:scf_auth/feature/registration/domain/entity/suggested_company.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../feature/cdn/domain/entity/key_value.dart';
import '../../feature/language/manager/localizatios.dart';
import '../../feature/registration/domain/entity/name_national_code.dart';
import 'enums.dart';
import 'ui_utils.dart';

extension DoubleExt on double {
  bool get isSmall => this <= 360;

  bool get isExtraSmall => this <= 311;

  double get scaleFactor => isExtraSmall
      ? .9
      : isSmall
          ? 1.0
          : 1.1;

  String get toTwoDigit {
    if (roundToDouble() == this) return '${round()}';
    return toStringAsFixed(2);
  }
}

extension IntExt on int {
  String toSizeStringValue(BuildContext context) {
    const int b = 1;
    const int kb = b * 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;
    if (this < kb) return '$this ${Strings.of(context).byte_label}';
    if (this < mb) {
      return '${(this / kb).toDouble().toTwoDigit} ${Strings.of(context).k_byte_label}';
    }
    if (this < gb) {
      return '${(this / mb).toDouble().toTwoDigit} ${Strings.of(context).m_byte_label}';
    }
    return '${(this / gb).toDouble().toTwoDigit} ${Strings.of(context).g_byte_label}';
  }

  bool get isValidFileSize => this <= Utils.maxFileSizeAllowed;

  String toStringValue(BuildContext context) {
    switch (this) {
      case 0:
      case 1:
        return '';
      case 2:
        return Strings.of(context).second_label;
      case 3:
        return Strings.of(context).third_label;
      case 4:
        return Strings.of(context).fourth_label;
      case 5:
        return Strings.of(context).fifth_label;
    }
    return '${toString().toWord()}م';
  }

  String get toCurrency {
    final NumberFormat formatter = NumberFormat.decimalPattern('fa');
    return formatter.format(this);
  }

  String get toPersianString => toString().toPersianNumber;

  String get toTwoDigit => this < 10 ? '0$this' : toString();
}

extension StringExt on String {
  bool get isValidWebsite {
    final regex = RegExp(
        r'^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*$');
    return regex.hasMatch(this);
  }

  bool get isValidEmail {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }

  bool get isValidMobileNumber {
    final regex = RegExp(r'^(\+98|0)?9\d{9}$');
    return regex.hasMatch(this);
  }

  String toCurrency(BuildContext context) {
    final temp = clearFormat;
    if (temp.isEmpty) return '';
    final intValue = int.tryParse(temp);
    if (intValue == null) return this;
    final toman = intValue ~/ 10;
    return Strings.of(context)
        .currency_place_holder
        .replaceFirst('\$0', temp.toWord())
        .replaceFirst('\$1', toman.toString().toWord());
  }

  bool get isValidNationalCode {
    if (!RegExp("^\\d{10}").hasMatch(this)) return false;
    final check = int.parse(this[9]);
    final sum = Iterable<int>.generate(9)
            .map((x) => int.parse(this[x]) * (10 - x))
            .reduce((x, y) => x + y) %
        11;
    return sum < 2 ? check == sum : check + sum == 11;
  }

  RegistrationSteps? get pathToRegistrationStep {
    switch (this) {
      case 'company-introduction':
        return RegistrationSteps.companyIntroduction;
      case 'management-introduction':
        return RegistrationSteps.managementIntroduction;
      case 'documents-upload':
        return RegistrationSteps.documentsUpload;
      case 'suggested-company':
        return RegistrationSteps.suggestedCompany;
      case 'contact-info':
        return RegistrationSteps.contactInfo;
      case 'suggested-branch':
        return RegistrationSteps.suggestedBranch;
    }
    return null;
  }

  String get securPan {
    if (clearFormat.length != 16) return this;
    final temp = clearFormat;
    return temp.secure(4, 12);
  }

  String get securIban {
    final temp = 'IR$clearFormat';
    if (temp.length != 26) return this;
    return temp.secure(6, 20);
  }

  String get securWallet {
    final temp = clearFormat;
    if (temp.length != 10) return this;
    return temp.secure(2, 8);
  }

  String secure(int start, int end) =>
      '${substring(0, start)}${List.generate(end - start, (index) => '*').join()}${substring(end)}'
          .toPersianNumber;

  bool get isValidCard {
    if (clearFormat.length != 16) return false;
    return true;
  }

  bool get isValidAmount {
    return int.tryParse(clearFormat) != null;
  }

  bool get isValidWallet => length == 10;

  String get clearFormat => replaceAll('-', '')
      .replaceAll(',', '')
      .replaceAll(' ', '')
      .replaceAll('IR', '')
      .toEnglishNumber;

  String get toCardFormat {
    final digits = this;
    StringBuffer buffer = StringBuffer();
    int offset = 0;
    int count = min(4, digits.length);
    final length = digits.length;
    for (; count <= length; count += min(4, max(1, length - count))) {
      buffer.write(digits.substring(offset, count));
      if (count < length) {
        buffer.write('-');
      }
      offset = count;
    }
    return buffer.toString().toPersianNumber;
  }

  String get toPersianNumber => replaceAll('1', '۱')
      .replaceAll('2', '۲')
      .replaceAll('3', '۳')
      .replaceAll('4', '۴')
      .replaceAll('5', '۵')
      .replaceAll('6', '۶')
      .replaceAll('7', '۷')
      .replaceAll('8', '۸')
      .replaceAll('9', '۹')
      .replaceAll('0', '۰');

  String get toEnglishNumber => replaceAll('۱', '1')
      .replaceAll('۲', '2')
      .replaceAll('۳', '3')
      .replaceAll('۴', '4')
      .replaceAll('۵', '5')
      .replaceAll('۶', '6')
      .replaceAll('۷', '7')
      .replaceAll('۸', '8')
      .replaceAll('۹', '9')
      .replaceAll('۰', '0');

  Jalali? get toJalali {
    final dateTime = DateTime.tryParse(this)?.toLocal();
    if (dateTime == null) return null;
    return Jalali.fromDateTime(dateTime).copy(
      hour: dateTime.hour,
      minute: dateTime.minute,
      second: dateTime.second,
      millisecond: dateTime.millisecond,
    );
  }
}

extension JalaliExt on Jalali {
  String get toTimeString =>
      '${hour.toTwoDigit}:${minute.toTwoDigit}:${second.toTwoDigit}';

  String get toDateString => '$year.${month.toTwoDigit}.${day.toTwoDigit}';
}

extension RegistrationStepsExt on RegistrationSteps {
  String toStringValue(BuildContext context) {
    switch (this) {
      case RegistrationSteps.companyIntroduction:
        return Strings.of(context).registration_steps_company_introduction;
      case RegistrationSteps.managementIntroduction:
        return Strings.of(context).registration_steps_management_introduction;
      case RegistrationSteps.documentsUpload:
        return Strings.of(context).registration_steps_documents_upload;
      case RegistrationSteps.suggestedCompany:
        return Strings.of(context).registration_steps_suggested_company;
      case RegistrationSteps.contactInfo:
        return Strings.of(context).registration_steps_contact_info;
      case RegistrationSteps.suggestedBranch:
        return Strings.of(context).registration_steps_suggested_branch;
    }
  }
}

extension CDNRequestTypeExt on CDNRequestType {
  String get toValue {
    switch (this) {
      case CDNRequestType.scfRegistrationActivityArea:
        return 'SCF-REGISTRATION-ACTIVITY-AREA';
      case CDNRequestType.scfRegistrationActivityType:
        return 'SCF-REGISTRATION-ACTIVITY-TYPE';
    }
  }
}

extension KeyValueNullableListExt on List<KeyValue?> {
  bool hasItemWithId(String? id) =>
      where((element) => element?.id == id).isNotEmpty;
}

extension KeyValueListExt on List<KeyValue> {
  List<KeyValue> filterWith(List<KeyValue?> selectedItems) {
    return where((element) => !selectedItems.hasItemWithId(element.id))
        .toList();
  }
}

extension ListExt<T> on List<T> {
  List<T> updateItemAt(int index, T item) {
    return [for (int i = 0; i < length; i++) index == i ? item : this[i]];
  }

  List<T> deleteItemAt(int index) {
    return [
      for (int i = 0; i < length; i++)
        if (index != i) this[i]
    ];
  }
}

extension NameNationalCodeListExt on List<NameNationalCode> {
  List<NameNationalCode> updateNameAt(int index, String name) {
    return [
      for (int i = 0; i < length; i++)
        index == i ? this[i].copyWith(name: name) : this[i]
    ];
  }

  List<NameNationalCode> updateNationalCodeAt(int index, String nationalCode) {
    return [
      for (int i = 0; i < length; i++)
        index == i ? this[i].copyWith(nationalCode: nationalCode) : this[i]
    ];
  }
}

extension UploadFileResultNullableListExt on List<UploadFileResult?> {
  List<UploadFileResult?> updateTitleAt(int index, String title) => [
        for (int i = 0; i < length; i++)
          index == i
              ? (this[i] ?? UploadFileResult.init()).copyWith(title: title)
              : this[i]
      ];
}

extension SuggestedCompanyListExt on List<SuggestedCompany> {
  List<SuggestedCompany> updateNameAt(int index, String name) => [
        for (int i = 0; i < length; i++)
          index == i ? this[i].copyWith(name: name) : this[i]
      ];

  List<SuggestedCompany> updateEconomicIdAt(int index, String economicId) => [
        for (int i = 0; i < length; i++)
          index == i ? this[i].copyWith(economicId: economicId) : this[i]
      ];

  List<SuggestedCompany> updateFinancialInteractionAt(
          int index, int? financialInteraction) =>
      [
        for (int i = 0; i < length; i++)
          index == i
              ? this[i].updateFinancialInteraction(financialInteraction)
              : this[i]
      ];
}
