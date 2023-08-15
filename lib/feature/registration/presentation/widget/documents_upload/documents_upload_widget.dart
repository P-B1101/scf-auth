import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/feature/file_manageer/presentation/widget/select_and_upload_with_title_widget.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../../injectable_container.dart';
import '../../../../file_manageer/presentation/widget/select_and_upload_widget.dart';
import '../../../../language/manager/localizatios.dart';
import '../../../../router/app_router.gr.dart';
import '../../../../toast/manager/toast_manager.dart';
import '../../cubit/registration_controller_cubit.dart';

@RoutePage()
class DocumentsUploadWidget extends StatefulWidget {
  const DocumentsUploadWidget({
    super.key,
  });

  @override
  State<DocumentsUploadWidget> createState() => _DocumentsUploadWidgetState();
}

class _DocumentsUploadWidgetState extends State<DocumentsUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: UiUtils.maxWidth + 48,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 56),
                        _titleWidget,
                        const SizedBox(height: 64),
                        _documentsListWidget,
                        const SizedBox(height: 42),
                        _dividerWidget,
                        const SizedBox(height: 14),
                        _otherDocumentTitle,
                        const SizedBox(height: 22),
                        _otherDocumentsList,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: _addActivityAreaButtonWidget,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _actionButtonsWidget,
      ],
    );
  }

  Widget get _titleWidget => Builder(
        builder: (context) => SizedBox(
          width: double.infinity,
          child: Text(
            Strings.of(context).documents_upload_title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: Fonts.regular400,
              color: MColors.textColorOf(context),
            ),
          ),
        ),
      );

  Widget get _documentsListWidget => Builder(
        builder: (context) => Wrap(
          spacing: 86,
          runSpacing: 40,
          children: [
            _statuteWidget,
            _newspaperWidget,
            _balanceSheetWidget,
            _profitAndLossStatementWidget,
          ],
        ),
      );

  Widget get _statuteWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.statute != current.statute),
        builder: (context, state) => SelectAndUploadWidget(
          onFileUploaded:
              context.read<RegistrationControllerCubit>().updateStatute,
          onFileExtensionFailure: _onFileExtensionFailure,
          onFileSizeFailure: _onFileSizeFailure,
          onFileFailure: _onFileFailure,
          hint: Strings.of(context).statute_hint,
          label: Strings.of(context).statute_label,
          title: state.statute?.title ?? Strings.of(context).statute_label,
          error: () {
            if (!state.showError || !state.invalidStatute) {
              return null;
            }
            return Strings.of(context).empty_statute_error;
          }(),
          name: state.statute?.fileName,
        ),
      );

  Widget get _newspaperWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.newspaper != current.newspaper),
        builder: (context, state) => SelectAndUploadWidget(
          onFileUploaded:
              context.read<RegistrationControllerCubit>().updateNewspaper,
          onFileExtensionFailure: _onFileExtensionFailure,
          onFileSizeFailure: _onFileSizeFailure,
          onFileFailure: _onFileFailure,
          hint: Strings.of(context).newspaper_hint,
          label: Strings.of(context).newspaper_label,
          title: state.newspaper?.title ?? Strings.of(context).newspaper_label,
          error: () {
            if (!state.showError || !state.invalidNewspaper) {
              return null;
            }
            return Strings.of(context).empty_newspaper_error;
          }(),
          name: state.newspaper?.fileName,
        ),
      );

  Widget get _balanceSheetWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.balanceSheet != current.balanceSheet),
        builder: (context, state) => SelectAndUploadWidget(
          onFileUploaded:
              context.read<RegistrationControllerCubit>().updateBalanceSheet,
          onFileExtensionFailure: _onFileExtensionFailure,
          onFileSizeFailure: _onFileSizeFailure,
          onFileFailure: _onFileFailure,
          hint: Strings.of(context).balance_sheet_hint,
          label: Strings.of(context).balance_sheet_label,
          title: state.balanceSheet?.title ??
              Strings.of(context).balance_sheet_label,
          error: () {
            if (!state.showError || !state.invalidBalanceSheet) {
              return null;
            }
            return Strings.of(context).empty_balance_sheet_error;
          }(),
          name: state.balanceSheet?.fileName,
        ),
      );

  Widget get _profitAndLossStatementWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.profitAndLossStatement != current.profitAndLossStatement),
        builder: (context, state) => SelectAndUploadWidget(
          onFileUploaded: context
              .read<RegistrationControllerCubit>()
              .updateProfitAndLossStatement,
          onFileExtensionFailure: _onFileExtensionFailure,
          onFileSizeFailure: _onFileSizeFailure,
          onFileFailure: _onFileFailure,
          hint: Strings.of(context).profit_and_loss_statement_hint,
          label: Strings.of(context).profit_and_loss_statement_label,
          title: state.profitAndLossStatement?.title ??
              Strings.of(context).profit_and_loss_statement_label,
          error: () {
            if (!state.showError || !state.invalidProfitAndLossStatement) {
              return null;
            }
            return Strings.of(context).empty_profit_and_loss_statement_error;
          }(),
          name: state.profitAndLossStatement?.fileName,
        ),
      );

  Widget get _dividerWidget => Builder(
        builder: (context) => Container(
          height: .5,
          width: double.infinity,
          color: MColors.primaryColor,
        ),
      );

  Widget get _otherDocumentTitle => Builder(
        builder: (context) => SizedBox(
          width: double.infinity,
          child: Text(
            Strings.of(context).other_documents_title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: Fonts.regular400,
              color: MColors.textColorOf(context),
            ),
          ),
        ),
      );

  Widget get _otherDocumentsList =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.otherDocuments != current.otherDocuments) ||
            (previous.showError != current.showError),
        builder: (context, state) {
          final items = state.otherDocuments;
          final length = items.length;
          return Column(
            children: List.generate(
              length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SelectAndUploadWithTitleWidget(
                  onFileUploaded: (result) => context
                      .read<RegistrationControllerCubit>()
                      .updateOtherDocumentsAt(index, result),
                  onFileExtensionFailure: _onFileExtensionFailure,
                  onFileSizeFailure: _onFileSizeFailure,
                  onFileFailure: _onFileFailure,
                  fileHint: Strings.of(context).other_document_hint,
                  titleHint: Strings.of(context).other_document_title_hint,
                  fileLabel: Strings.of(context).other_document_label,
                  titleLabel: Strings.of(context).other_document_title_label,
                  title: state.profitAndLossStatement?.title,
                  fileError: () {
                    if (!state.showError ||
                        !state.invalidOtherDocumentsFile ||
                        (state.otherDocuments[index] != null &&
                            !state.otherDocuments[index]!.invalidFile)) {
                      return null;
                    }
                    return Strings.of(context)
                        .empty_other_document_error
                        .replaceFirst(
                            '\$0',
                            state.otherDocuments[index]?.title ??
                                Strings.of(context).other_document_label);
                  }(),
                  titleError: () {
                    if (!state.showError ||
                        !state.invalidOtherDocumentsTitle ||
                        (state.otherDocuments[index] != null &&
                            !state.otherDocuments[index]!.invalidTitle)) {
                      return null;
                    }
                    return Strings.of(context).empty_other_document_title_error;
                  }(),
                  name: state.otherDocuments[index]?.fileName,
                  onTitleChange: (title) => context
                      .read<RegistrationControllerCubit>()
                      .updateOtherDocumentsTitleAt(index, title),
                  onDeleteClick: index > 0
                      ? () => context
                          .read<RegistrationControllerCubit>()
                          .deleteOtherDocument(index)
                      : null,
                ),
              ),
            ),
          );
        },
      );

  Widget get _addActivityAreaButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) =>
            (previous.canAddOtherDocuments != current.canAddOtherDocuments) ||
            (previous.otherDocuments != current.otherDocuments),
        builder: (context, state) => SizedBox(
          width: UiUtils.maxInputSize,
          child: AnimatedCrossFade(
            duration: UiUtils.duration,
            sizeCurve: UiUtils.curve,
            firstCurve: UiUtils.curve,
            secondCurve: UiUtils.curve,
            crossFadeState: state.canAddOtherDocuments
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: MButtonWidget.textWithIcon(
                onClick: _onAddMoreOtherDocumentsClick,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10,
                    bottom: 10,
                    end: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Fonts.plus,
                          size: 12,
                          color: MColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Strings.of(context).add_more_documents,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: Fonts.regular400,
                          color: MColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            secondChild: const SizedBox(width: UiUtils.maxInputSize),
          ),
        ),
      );

  Widget get _actionButtonsWidget => Builder(
        builder: (context) => Container(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxWidth),
          padding: const EdgeInsets.only(bottom: 56, top: 24),
          child: Wrap(
            spacing: 86,
            runSpacing: 40,
            children: [
              _backButtonWidget,
              _nextButtonWidget,
            ],
          ),
        ),
      );

  Widget get _nextButtonWidget =>
      BlocBuilder<RegistrationControllerCubit, RegistrationControllerState>(
        buildWhen: (previous, current) => previous.isEnable != current.isEnable,
        builder: (context, state) => MButtonWidget(
          onClick: _onDocumentsUploadNextClick,
          title: Strings.of(context).next_step_label,
          width: UiUtils.maxInputSize,
          isEnable: state.isEnable,
        ),
      );

  Widget get _backButtonWidget => Builder(
        builder: (context) => MButtonWidget.outline(
          onClick: _onBackClick,
          title: Strings.of(context).back_step_label,
          width: UiUtils.maxInputSize,
        ),
      );

  void _onFileExtensionFailure(String extension) {
    final message = Strings.of(context)
        .file_extension_failure_message
        .replaceFirst('\$0', '"$extension"')
        .replaceFirst(
            '\$1', Utils.allowedExtensions.map((e) => '"$e"').join(', '));
    getIt<ToastManager>().showFailureToast(
      context: context,
      message: message,
    );
  }

  void _onFileSizeFailure(int size) {
    final message = Strings.of(context)
        .file_size_failure_message
        .replaceFirst('\$0', '"${size.toSizeStringValue(context)}"')
        .replaceFirst(
            '\$1', Utils.maxFileSizeAllowed.toSizeStringValue(context));
    getIt<ToastManager>().showFailureToast(
      context: context,
      message: message,
    );
  }

  void _onFileFailure(String? message) {
    getIt<ToastManager>().showFailureToast(
      context: context,
      message: message,
    );
  }

  void _onBackClick() {
    final state = context.read<RegistrationControllerCubit>().onBackClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.replaceRoute(const ManagementIntroductionRoute());
  }

  void _onAddMoreOtherDocumentsClick() {
    context.read<RegistrationControllerCubit>().addOtherDocuments();
  }

  void _onDocumentsUploadNextClick() {
    final state = context.read<RegistrationControllerCubit>().onNextClick();
    if (state == null) return;
    AutoTabsRouter.of(context).setActiveIndex(state.step.index);
    context.replaceRoute(const SuggestedCompanyRoute());
  }
}
