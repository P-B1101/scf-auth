import 'package:flutter/material.dart';
import 'package:scf_auth/core/components/input/m_input_widget.dart';

class ReadOnlyWidgets extends StatelessWidget {
  const ReadOnlyWidgets({
    super.key,
    required this.title,
    required this.hintTxt,
    required this.controller,
    required this.focusNode,
  });

  final String title;
  final String hintTxt;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle()),
        MInputWidget(
          controller: controller,
          focusNode: focusNode,
          hint: hintTxt,
        ),
      ],
    );
  }
}
