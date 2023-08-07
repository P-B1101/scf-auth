import 'dart:math';

import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DoubleExt on double {
  bool get isSmall => this <= 360;

  bool get isExtraSmall => this <= 311;

  double get scaleFactor => isExtraSmall
      ? .9
      : isSmall
          ? 1.0
          : 1.1;
}

extension IntExt on int {
  String get toCurrency {
    final NumberFormat formatter = NumberFormat.decimalPattern('fa');
    return formatter.format(this);
  }

  String get toPersianString => toString().toPersianNumber;

  String get toTwoDigit => this < 10 ? '0$this' : toString();
}

extension StringExt on String {
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
