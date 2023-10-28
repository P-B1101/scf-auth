import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:scf_auth/core/utils/assets.dart';
import 'package:scf_auth/core/utils/extensions.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/components/text/input_label_widget.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';

class NameNationalCodeFieldWidget extends StatefulWidget {
  final Function(String) onNameChange;
  final Function(String) onNationalCodeChange;
  final Function(Jalali) onBirthDateChange;
  final String name;
  final String nationalCode;
  final Jalali? birthDate;
  final String nameLabel;
  final String nameHint;
  final String nationalCodeLabel;
  final String nationalCodeHint;
  final String birthDateLabel;
  final String birthDateHint;
  final String? nameError;
  final String? nationalCodeError;
  final String? birthDateError;
  final Function()? onDeleteFieldClick;
  final bool hasDivider;
  final bool requestFocus;
  const NameNationalCodeFieldWidget({
    super.key,
    required this.onNameChange,
    required this.onNationalCodeChange,
    required this.onBirthDateChange,
    required this.name,
    required this.nationalCode,
    required this.nameHint,
    required this.nameLabel,
    required this.nationalCodeHint,
    required this.nationalCodeLabel,
    required this.birthDate,
    required this.birthDateHint,
    required this.birthDateLabel,
    required this.hasDivider,
    this.requestFocus = false,
    this.nameError,
    this.nationalCodeError,
    this.onDeleteFieldClick,
    this.birthDateError,
  });

  @override
  State<NameNationalCodeFieldWidget> createState() =>
      _NameNationalCodeFieldWidgetState();
}

class _NameNationalCodeFieldWidgetState
    extends State<NameNationalCodeFieldWidget> {
  final _nameController = TextEditingController();
  final _nationalCodeController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _nameNode = FocusNode();
  final _nationalCodeNode = FocusNode();
  final _birthDateCodeNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _nationalCodeController.text = widget.nationalCode;
    _birthDateController.text = widget.birthDate?.toDateString ?? '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.requestFocus) _nameNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nationalCodeController.dispose();
    _nameNode.dispose();
    _nationalCodeNode.dispose();
    _birthDateController.dispose();
    _birthDateCodeNode.dispose();
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
            _nationalCodeWidget,
            _birthDateWidget,
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
                widget.nameLabel,
                hasError: _hasNameError,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _nameController,
                focusNode: _nameNode,
                nextFocusNode: _nationalCodeNode,
                autofillHints: const [AutofillHints.name],
                hint: widget.nameHint,
                onTextChange: widget.onNameChange,
                error: widget.nameError,
              ),
            ],
          ),
        ),
      );

  Widget get _nationalCodeWidget => Builder(
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                widget.nationalCodeLabel,
                hasError: _hasNationalCodeError,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                controller: _nationalCodeController,
                focusNode: _nationalCodeNode,
                autofillHints: const [AutofillHints.username],
                hint: widget.nationalCodeHint,
                onTextChange: widget.onNationalCodeChange,
                error: widget.nationalCodeError,
                maxLength: 10,
              ),
            ],
          ),
        ),
      );

  Widget get _birthDateWidget => Builder(
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                widget.birthDateLabel,
                hasError: _hasBirthDateError,
              ),
              const SizedBox(height: 18),
              MInputWidget(
                onTap: _selectDate,
                controller: _birthDateController,
                focusNode: _birthDateCodeNode,
                autofillHints: const [AutofillHints.birthday],
                hint: widget.birthDateHint,
                error: widget.birthDateError,
                isReadOnly: true,
                suffixWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: Center(
                      child: Icon(
                        Icons.calendar_month_rounded,
                        size: 24,
                        color: MColors.inputBorderColorOf(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _deleteWidget => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 12),
          child: MButtonWidget.textWithIcon(
            onClick: _onDeleteClick,
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
                      Strings.of(context).delete_board_member,
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

  bool get _hasNationalCodeError =>
      widget.nationalCodeError != null && widget.nationalCodeError!.isNotEmpty;

  bool get _hasBirthDateError =>
      widget.birthDateError != null && widget.birthDateError!.isNotEmpty;

  bool get _hasDelete => widget.onDeleteFieldClick != null;

  void _onDeleteClick() {
    _nameController.clear();
    _nationalCodeController.clear();
    _nationalCodeController.clear();
    widget.onDeleteFieldClick?.call();
  }

  void _selectDate() async {
    final result = await showPersianDatePicker(
      context: context,
      initialDate: widget.birthDate ?? Jalali.now(),
      firstDate: Jalali.MIN,
      lastDate: Jalali.now(),
    );
    if (!mounted) return;
    if (result == null) return;
    widget.onBirthDateChange(result);
    _birthDateController.text = result.toDateString;
  }
}
