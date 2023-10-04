import 'package:flutter/material.dart';
import 'package:scf_auth/core/components/input/currency_input_widget.dart';
import 'package:scf_auth/core/components/input/m_input_widget.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/ui_utils.dart';

class ReadOnlyWidgets extends StatefulWidget {
  const ReadOnlyWidgets({
    super.key,
    required this.label,
    required this.hintTxt,
    required this.value,
    this.seeDocIcon,
    this.onSeeDocumentClick,
    this.isCurrency = false,
    this.isLong = false,
  });

  final String? label;
  final String hintTxt;
  final String? value;
  final IconData? seeDocIcon;
  final bool isLong;
  final bool isCurrency;
  final Function()? onSeeDocumentClick;

  @override
  State<ReadOnlyWidgets> createState() => _ReadOnlyWidgetsState();
}

class _ReadOnlyWidgetsState extends State<ReadOnlyWidgets> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value ?? '';
  }

  @override
  void didUpdateWidget(covariant ReadOnlyWidgets oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.text = widget.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label ?? '',
            style: const TextStyle(
              color: MColors.primaryTextColor,
              fontSize: 14,
              fontWeight: Fonts.regular400,
            ),
          )
        else
          const Text(""),
        const SizedBox(height: 18),
        if (!widget.isCurrency)
          SizedBox(
            width: (widget.isLong) ? double.infinity : UiUtils.maxInputSize,
            child: MInputWidget(
              controller: _controller,
              focusNode: _focusNode,
              hint: widget.hintTxt,
              isReadOnly: true,
              suffixWidget: Padding(
                padding: const EdgeInsetsDirectional.only(end: 13),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: widget.onSeeDocumentClick,
                    child: Icon(
                      size: 22,
                      widget.seeDocIcon,
                      color: MColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          SizedBox(
            width: UiUtils.maxInputSize,
            child: CurrencyInputWidget(
              controller: _controller,
              focusNode: _focusNode,
              hint: widget.hintTxt,
              isReadOnly: true,
            ),
          ),
      ],
    );
  }
}
