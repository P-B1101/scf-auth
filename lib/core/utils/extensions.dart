import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'package:iban/iban.dart' as i_validation;
import '../../feature/cdn/domain/entity/key_value.dart';
import '../../feature/cdn/domain/entity/province_city.dart';
import '../../feature/cdn/domain/entity/upload_file_result.dart';
import '../../feature/language/manager/localizatios.dart';
import '../../feature/registration/domain/entity/address_info.dart';
import '../../feature/registration/domain/entity/director.dart';
import '../../feature/registration/domain/entity/suggested_company.dart';
import '../../feature/registration/presentation/widget/company_introduction/company_introduction_widget.dart';
import '../../feature/registration/presentation/widget/contact_info/contact_info_widget.dart';
import '../../feature/registration/presentation/widget/documents_upload/documents_upload_widget.dart';
import '../../feature/registration/presentation/widget/finalize/finalize_info_widget.dart';
import '../../feature/registration/presentation/widget/management_introduction/management_introduction_widget.dart';
import '../../feature/registration/presentation/widget/suggested_branch/suggested_branch_widget.dart';
import '../../feature/registration/presentation/widget/suggested_company/suggested_company_widget.dart';
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
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this * 1000);

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
  Jalali? get toLocalJalali {
    final date = DateTime.tryParse(this)?.toLocal();
    if (date == null) return null;
    final jalali = Jalali.fromDateTime(date).copy(
      hour: date.hour,
      minute: date.minute,
      second: date.second,
    );
    return jalali;
  }

  Jalali? get toJalali {
    final dateTime = DateTime.tryParse(this)?.toLocal();
    if (dateTime == null) return null;
    return Jalali.fromDateTime(dateTime).copy(
      hour: dateTime.hour,
      minute: dateTime.minute,
      second: dateTime.second,
    );
  }

  bool get isValidIban {
    final temp = clearFormat.startsWith('IR') ? clearFormat : 'IR$clearFormat';
    return i_validation.isValid(temp);
  }

  ActivityType? get toActivityType => switch (this) {
        'PRODUCT' => ActivityType.product,
        'SERVICE' => ActivityType.service,
        _ => null,
      };

  bool get isValidOtp => length == 6;
  Position? get toPosition {
    switch (this) {
      case 'CEO':
        return Position.ceo;
      case 'MEMBER':
        return Position.member;
    }
    return null;
  }

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
      case CompanyIntroductionWidget.path:
        return RegistrationSteps.companyIntroduction;
      case ManagementIntroductionWidget.path:
        return RegistrationSteps.managementIntroduction;
      case DocumentsUploadWidget.path:
        return RegistrationSteps.documentsUpload;
      case SuggestedCompanyWidget.path:
        return RegistrationSteps.suggestedCompany;
      case ContactInfoWidget.path:
        return RegistrationSteps.contactInfo;
      case SuggestedBranchWidget.path:
        return RegistrationSteps.suggestedBranch;
      case FinalizeInfoWidget.path:
        return RegistrationSteps.finalize;
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

  Jalali? get toJalaliLocal {
    final dateTime = DateTime.tryParse(this)?.toLocal();
    if (dateTime == null) return null;
    return Jalali.fromDateTime(dateTime).copy(
      hour: dateTime.hour,
      minute: dateTime.minute,
      second: dateTime.second,
    );
  }
}

extension JalaliExt on Jalali {
  String get toTimeString =>
      '${hour.toTwoDigit}:${minute.toTwoDigit}:${second.toTwoDigit}';

  String get toDateString => '$year/${month.toTwoDigit}/${day.toTwoDigit}';

  String get toValue => toDateTime().toValue;
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
      case RegistrationSteps.finalize:
        return Strings.of(context).registration_steps_finalize;
    }
  }
}

extension CDNRequestTypeExt on CDNRequestType {
  String get toValue {
    switch (this) {
      case CDNRequestType.scfRegistrationActivityArea:
        return 'SCF-REGISTRATION-ACTIVITY-AREA';
      // case CDNRequestType.scfRegistrationActivityType:
      //   return 'SCF-REGISTRATION-ACTIVITY-TYPE';
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

extension NameNationalCodeListExt on List<Director> {
  List<Director> updateNameAt(int index, String name) {
    return [
      for (int i = 0; i < length; i++)
        index == i ? this[i].copyWith(name: name) : this[i]
    ];
  }

  List<Director> updateNationalCodeAt(int index, String nationalCode) {
    return [
      for (int i = 0; i < length; i++)
        index == i ? this[i].copyWith(nationalCode: nationalCode) : this[i]
    ];
  }

  List<Director> updateBirthDateAt(int index, Jalali birthDate) {
    return [
      for (int i = 0; i < length; i++)
        index == i ? this[i].copyWith(birthDate: birthDate) : this[i]
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
          index == i ? this[i].copyWith(nationalId: economicId) : this[i]
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

extension AddressInfoListExt on List<AddressInfo> {
  List<AddressInfo> updateAddressAddressAt(int index, String address) => [
        for (int i = 0; i < length; i++)
          index == i ? this[i].copyWith(address: address) : this[i]
      ];

  List<AddressInfo> updateAddressProvinceAt(int index, ProvinceCity province) =>
      [
        for (int i = 0; i < length; i++)
          index == i ? this[i].copyWith(province: province) : this[i]
      ];

  List<AddressInfo> updateAddressCityAt(int index, [ProvinceCity? city]) => [
        for (int i = 0; i < length; i++)
          index == i ? this[i].updateCity(city) : this[i]
      ];

  List<AddressInfo> updateAddressLatLntAt(
    int index,
    double? lat,
    double? lng,
  ) =>
      [
        for (int i = 0; i < length; i++)
          index == i ? this[i].updateLatLng(lat, lng) : this[i]
      ];
}

extension PositionExt on Position {
  String get toValue => switch (this) {
        Position.member => 'MEMBER',
        Position.ceo => 'CEO',
      };
}

extension TargetPlatformTypeExt on TargetPlatformType {
  String get toValue => switch (this) {
        TargetPlatformType.androidNative => 'ANDROID_NATIVE',
        TargetPlatformType.androidPwa => 'ANDROID_PWA',
        TargetPlatformType.iosNative => 'IOS_NATIVE',
        TargetPlatformType.iosPwa => 'IOS_PWA',
        TargetPlatformType.other => 'OTHER',
      };
}

// extension DurationExt on Duration {
//   String get toMinuteAndSecond {
//     final data = inSeconds;
//     final minute = data ~/ 60;
//     final seconds = data % 60;
//     return '${minute.toTwoDigit}:${seconds.toTwoDigit}';
//   }
// }

extension ActivityTypeExt on ActivityType {
  String toStringValue(BuildContext context) => switch (this) {
        ActivityType.product => Strings.of(context).activity_type_product,
        ActivityType.service => Strings.of(context).activity_type_service,
      };

  String get toValue => switch (this) {
        ActivityType.product => 'PRODUCT',
        ActivityType.service => 'SERVICE',
      };
}

extension DateTimeExt on DateTime {
  String get toValue =>
      '$year-${month.toTwoDigit}-${day.toTwoDigit}T${hour.toTwoDigit}:${minute.toTwoDigit}:${second.toTwoDigit}';
}

extension MapStringDynamicExt on Map<String, dynamic> {
  Jalali? toJalali(String key) {
    final value = this[key];
    if (value is! String) return null;
    return value.toJalali;
  }

  Jalali? toLocalJalali(String key) {
    final value = this[key];
    if (value is! String) return null;
    return value.toLocalJalali;
  }

  T? toEnum<T extends Enum>(String key, T? Function(String value) converter) {
    final value = this[key];
    if (value is! String) return null;
    return converter(value);
  }

  T? toModel<T extends Equatable>(
    String key,
    T? Function(dynamic value) converter,
  ) {
    final value = this[key];
    if (value == null) return null;
    return converter(value);
  }

  List<T> toListModel<T extends Equatable>(
    String key,
    T Function(dynamic value) converter,
  ) {
    final value = this[key];
    if (value is! List) return <T>[];
    return value.map((e) => converter(e)).toList();
  }
}

extension UploadFileTypeExt on UploadFileType {
  String get toValue => switch (this) {
        UploadFileType.registration =>
          'scf-registration/upload/registration-document',
      };
}
