import 'package:flutter/material.dart';
import 'package:scf_auth/core/components/button/m_button.dart';
import 'package:scf_auth/core/components/input/currency_input_widget.dart';
import 'package:scf_auth/core/utils/assets.dart';
import 'package:scf_auth/core/utils/extensions.dart';

import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/components/text/input_label_widget.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';

typedef TextChangeListener = void Function(String value);
typedef IntChangeListener = void Function(int? value);

class SuggestedCompanyInfoWidget extends StatefulWidget {
  final String name;
  final String economicId;
  final int? financialInteraction;
  final String? nameError;
  final String? economicIdError;
  final String? financialInteractionError;
  final TextChangeListener onNameChange;
  final TextChangeListener onEconomicIdChange;
  final IntChangeListener onFinancialInteractionChange;
  final Function()? onDeleteClick;
  final bool hasDivider;
  final bool requestFocus;

  const SuggestedCompanyInfoWidget({
    super.key,
    required this.economicId,
    required this.financialInteraction,
    required this.name,
    required this.onNameChange,
    required this.onEconomicIdChange,
    required this.onFinancialInteractionChange,
    required this.economicIdError,
    required this.financialInteractionError,
    required this.nameError,
    required this.hasDivider,
    required this.onDeleteClick,
    this.requestFocus = false,
  });

  @override
  State<SuggestedCompanyInfoWidget> createState() =>
      _SuggestedCompanyInfoWidgetState();
}

class _SuggestedCompanyInfoWidgetState
    extends State<SuggestedCompanyInfoWidget> {
  final _nameController = TextEditingController();
  final _economicIdController = TextEditingController();
  final _financialInteractionController = TextEditingController();

  final _nameNode = FocusNode();
  final _economicIdNode = FocusNode();
  final _financialInteractionNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _economicIdController.text = widget.economicId;
    final amount =
        widget.financialInteraction?.toCurrency.toEnglishNumber ?? '';
    _financialInteractionController.text = amount;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.requestFocus) _nameNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _economicIdController.dispose();
    _financialInteractionController.dispose();
    _nameNode.dispose();
    _economicIdNode.dispose();
    _financialInteractionNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 86,
          runSpacing: 40,
          children: [
            _nameWidget,
            _economicIdWidget,
            _financialInteractionWidget,
          ],
        ),
        if (_hasDelete)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: _deleteWidget,
          ),
        if (widget.hasDivider) const SizedBox(height: 40),
        if (widget.hasDivider) _dividerWidget,
      ],
    );
  }

  Widget get _nameWidget => Builder(
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).suggested_company_name_label,
                hasError: _hasNameError,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _nameController,
                focusNode: _nameNode,
                nextFocusNode: _economicIdNode,
                autofillHints: const [AutofillHints.organizationName],
                hint: Strings.of(context).suggested_company_name_hint,
                onTextChange: widget.onNameChange,
                error: widget.nameError,
              ),
            ],
          ),
        ),
      );

  Widget get _economicIdWidget => Builder(
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context).suggested_company_economic_id_label,
                hasError: _hasEconomicIdError,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _economicIdController,
                focusNode: _economicIdNode,
                nextFocusNode: _financialInteractionNode,
                hint: Strings.of(context).suggested_company_economic_id_hint,
                onTextChange: widget.onEconomicIdChange,
                error: widget.economicIdError,
              ),
            ],
          ),
        ),
      );

  Widget get _financialInteractionWidget => Builder(
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                Strings.of(context)
                    .suggested_company_financial_interaction_label,
                hasError: _hasFinancialInteractionError,
              ),
              const SizedBox(height: 18),
              CurrencyInputWidget(
                controller: _financialInteractionController,
                focusNode: _financialInteractionNode,
                hint: Strings.of(context)
                    .suggested_company_financial_interaction_hint,
                onTextChange: (value) =>
                    widget.onFinancialInteractionChange(int.tryParse(
                  value.clearFormat,
                )),
                error: widget.financialInteractionError,
              ),
            ],
          ),
        ),
      );

  Widget get _deleteWidget => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 12),
          child: MButtonWidget.textWithIcon(
            onClick: () => widget.onDeleteClick?.call(),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 5,
                bottom: 10,
                end: 16,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Fonts.trash,
                      size: 20,
                      color: MColors.inputBorderColorOf(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      Strings.of(context).delete_suggested_company,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: Fonts.regular400,
                        color: MColors.inputBorderColorOf(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget get _dividerWidget => Builder(
        builder: (context) => Container(
          height: .5,
          width: double.infinity,
          color: MColors.primaryColor,
        ),
      );

  bool get _hasNameError =>
      widget.nameError != null && widget.nameError!.isNotEmpty;

  bool get _hasEconomicIdError =>
      widget.economicIdError != null && widget.economicIdError!.isNotEmpty;

  bool get _hasFinancialInteractionError =>
      widget.financialInteractionError != null &&
      widget.financialInteractionError!.isNotEmpty;

  bool get _hasDelete => widget.onDeleteClick != null;
}
