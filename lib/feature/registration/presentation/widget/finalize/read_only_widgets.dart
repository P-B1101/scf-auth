import 'package:flutter/material.dart';
import 'package:scf_auth/core/components/input/m_input_widget.dart';

import '../../../../../core/utils/ui_utils.dart';

class ReadOnlyWidgets extends StatefulWidget {
  const ReadOnlyWidgets({
    super.key,
    required this.label,
    required this.hintTxt,
    required this.value,
  });

  final String? label;
  final String hintTxt;
  final String? value;

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
        Text(widget.label ?? '', style: const TextStyle()),
        const SizedBox(height: 18),
        SizedBox(
          width: UiUtils.maxInputSize,
          child: MInputWidget(
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
