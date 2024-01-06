import 'package:equatable/equatable.dart';
import 'package:scf_auth/core/utils/ui_utils.dart';

class UploadFileResult extends Equatable {
  final String urn;
  final String fileName;
  final String title;

  const UploadFileResult({
    required this.fileName,
    required this.urn,
    required this.title,
  });

  @override
  List<Object?> get props => [urn, fileName, title];

  factory UploadFileResult.init() =>
      const UploadFileResult(fileName: '', urn: '', title: '');

  UploadFileResult copyWith({
    String? fileName,
    String? title,
    String? urn,
  }) =>
      UploadFileResult(
        fileName: fileName ?? this.fileName,
        urn: urn ?? this.urn,
        title: title ?? this.title,
      );

  bool get invalidFile => fileName.isEmpty;

  bool get invalidTitle => title.isEmpty;

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
