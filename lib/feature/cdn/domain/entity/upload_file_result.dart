import 'package:equatable/equatable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../core/utils/ui_utils.dart';

class UploadFileResult extends Equatable {
  final String? urn;
  final String? fileName;
  final String? title;
  final Jalali? uploadDate;

  const UploadFileResult({
    required this.fileName,
    required this.urn,
    required this.title,
    required this.uploadDate,
  });

  @override
  List<Object?> get props => [
        urn,
        fileName,
        title,
        uploadDate,
      ];

  factory UploadFileResult.init() => const UploadFileResult(
        fileName: '',
        urn: '',
        title: '',
        uploadDate: null,
      );

  UploadFileResult copyWith({
    String? fileName,
    String? title,
    String? urn,
    String? id,
    Jalali? uploadDate,
  }) =>
      UploadFileResult(
        fileName: fileName ?? this.fileName,
        urn: urn ?? this.urn,
        title: title ?? this.title,
        uploadDate: uploadDate ?? this.uploadDate,
      );

  bool get invalidFile => fileName?.isEmpty ?? true;

  bool get invalidTitle => title?.isEmpty ?? true;

  bool get isBalanceSheetTitle => title == Utils.balanceSheetTitle;

  bool get isStatuteTitle => title == Utils.statuteTitle;

  bool get isNewspaperTitle => title == Utils.newspaperTitle;

  bool get isProfitAndLossStatementTitle =>
      title == Utils.profitAndLossStatementTitle;

  bool get isCashFlowTitle => title == Utils.cashFlow;

  bool get isNotSpecific =>
      !isStatuteTitle &&
      !isNewspaperTitle &&
      !isProfitAndLossStatementTitle &&
      !isCashFlowTitle &&
      !isBalanceSheetTitle;
}
