import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/assets.dart';

import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/components/text/input_label_widget.dart';
import '../../../../../core/utils/ui_utils.dart';

class NameNationalCodeFieldWidget extends StatefulWidget {
  final Function(String) onNameChange;
  final Function(String) onNationalCodeChange;
  final String name;
  final String nationalCode;
  final String nameLabel;
  final String nameHint;
  final String nationalCodeLabel;
  final String nationalCodeHint;
  final String? nameError;
  final String? nationalCodeError;
  final Function()? onDeleteFieldClick;
  final bool requestFocus;
  const NameNationalCodeFieldWidget({
    super.key,
    required this.onNameChange,
    required this.onNationalCodeChange,
    required this.name,
    required this.nationalCode,
    required this.nameHint,
    required this.nameLabel,
    required this.nationalCodeHint,
    required this.nationalCodeLabel,
    this.requestFocus = false,
    this.nameError,
    this.nationalCodeError,
    this.onDeleteFieldClick,
  });

  @override
  State<NameNationalCodeFieldWidget> createState() =>
      _NameNationalCodeFieldWidgetState();
}

class _NameNationalCodeFieldWidgetState
    extends State<NameNationalCodeFieldWidget> {
  final _nameController = TextEditingController();
  final _nationalCodeController = TextEditingController();
  final _nameNode = FocusNode();
  final _nationalCodeNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _nationalCodeController.text = widget.nationalCode;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 86,
      runSpacing: 40,
      children: [
        _nameWidget,
        _nationalCodeWidget,
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
                suffixWidget: _hasDelete
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: InkWell(
                            onTap: _onDeleteClick,
                            customBorder: const CircleBorder(),
                            child: Center(
                              child: Icon(
                                Fonts.trash,
                                size: 20,
                                color: MColors.inputBorderColorOf(context),
                              ),
                            ),
                          ),
                        ),
                      )
                    : null,
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

  bool get _hasNameError =>
      widget.nameError != null && widget.nameError!.isNotEmpty;

  bool get _hasNationalCodeError =>
      widget.nationalCodeError != null && widget.nationalCodeError!.isNotEmpty;

  bool get _hasDelete => widget.onDeleteFieldClick != null;

  void _onDeleteClick() {
    _nameController.clear();
    _nationalCodeController.clear();
    widget.onDeleteFieldClick?.call();
  }
}
