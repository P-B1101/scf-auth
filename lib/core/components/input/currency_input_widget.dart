import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scf_auth/core/utils/assets.dart';
import 'package:scf_auth/feature/language/manager/localizatios.dart';

import '../../utils/extensions.dart';
import 'm_input_widget.dart';

class _Cubit extends Cubit<_State> {
  _Cubit() : super(const _State(text: ''));

  void onTextChange(String text) => emit(_State(text: text));
}

class _State extends Equatable {
  final String text;
  const _State({
    required this.text,
  });
  @override
  List<Object?> get props => [text];

  bool get hasValidAmount => text.isValidAmount;
}

class CurrencyInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onTextChange;
  final String hint;
  final String? error;
  const CurrencyInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.onTextChange,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<_Cubit>(
          create: (context) => _Cubit(),
        ),
      ],
      child: _CurrencyInputWidget(
        controller: controller,
        focusNode: focusNode,
        hint: hint,
        onTextChange: onTextChange,
        error: error,
      ),
    );
  }
}

class _CurrencyInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final Function(String)? onTextChange;
  final String? error;
  const _CurrencyInputWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.onTextChange,
    required this.error,
  }) : super(key: key);

  @override
  State<_CurrencyInputWidget> createState() => _CurrencyInputWidgetState();
}

class _CurrencyInputWidgetState extends State<_CurrencyInputWidget> {
  final _digitFormatter = MPersianNumberFormatter();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MInputWidget(
          controller: widget.controller,
          focusNode: widget.focusNode,
          hint: widget.hint,
          contentPadding: const EdgeInsetsDirectional.only(
            start: 21,
            end: 54,
            top: 18,
            bottom: 18,
          ),
          keyboardType: TextInputType.phone,
          maxLength: 25,
          closeKeyboardOnFinish: false,
          inputFormatters: [
            _digitFormatter,
          ],
          textInputAction: TextInputAction.done,
          onTextChange: (value) {
            context.read<_Cubit>().onTextChange(value);
            widget.onTextChange?.call(value);
          },
          error: widget.error,
          suffixWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              Strings.of(context).rial,
              style: TextStyle(
                fontFamily: Fonts.yekan,
                color: MColors.inputTextColorOf(context),
                fontSize: 14,
                fontWeight: Fonts.regular400,
              ),
            ),
          ),
        ),
        // BlocBuilder<_Cubit, _State>(
        //   buildWhen: (previous, current) =>
        //       previous.hasValidAmount != current.hasValidAmount,
        //   builder: (context, state) => AnimatedCrossFade(
        //     duration: UiUtils.duration,
        //     sizeCurve: Curves.ease,
        //     firstCurve: Curves.ease,
        //     secondCurve: Curves.ease,
        //     crossFadeState: _hasError || state.hasValidAmount
        //         ? CrossFadeState.showFirst
        //         : CrossFadeState.showSecond,
        //     firstChild: _labelWidget,
        //     secondChild: const SizedBox(width: double.infinity),
        //   ),
        // ),
      ],
    );
  }

  // Widget get _labelWidget => BlocBuilder<_Cubit, _State>(
  //       builder: (context, state) => Container(
  //         width: double.infinity,
  //         margin: const EdgeInsets.only(left: 8, right: 8, top: 6),
  //         child: AnimatedDefaultTextStyle(
  //           duration: UiUtils.duration,
  //           curve: UiUtils.curve,
  //           style: TextStyle(
  //             fontFamily: Fonts.yekan,
  //             color: _hasError
  //                 ? MColors.errorColor
  //                 : MColors.textColorOf(context).withOpacity(.65),
  //           ),
  //           child: Text(
  //             _hasError
  //                 ? widget.error?.toPersianNumber ?? ''
  //                 : state.text.toCurrency(context),
  //             style: const TextStyle(
  //               fontWeight: Fonts.medium500,
  //               fontSize: 12,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  // bool get _hasError => widget.error != null && widget.error!.isNotEmpty;
}

class MPersianNumberFormatter extends TextInputFormatter {
  static final RegExp _digitOnlyRegex = RegExp(r'\d+');
  static final FilteringTextInputFormatter _digitOnlyFormatter =
      FilteringTextInputFormatter.allow(_digitOnlyRegex);

  MPersianNumberFormatter();

  TextEditingValue? _lastNewValue;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    oldValue = oldValue.copyWith(text: oldValue.text.toEnglishNumber);
    newValue = newValue.copyWith(text: newValue.text.toEnglishNumber);

    /// nothing changes, nothing to do
    if (newValue.text == _lastNewValue?.text) {
      return newValue.copyWith(text: newValue.text.toPersianNumber);
    }
    _lastNewValue = newValue;

    /// remove all invalid characters
    newValue = _formatValue(oldValue, newValue);

    /// current selection
    int selectionIndex = newValue.selection.end;

    /// format original string, this step would add some separator
    /// characters to original string
    final newText = _formatPattern(newValue.text);

    /// count number of inserted character in new string
    int insertCount = 0;

    /// count number of original input character in new string
    int inputCount = 0;
    for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (_isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    /// adjust selection according to number of inserted characters staying before
    /// selection
    selectionIndex += insertCount;
    selectionIndex = min(selectionIndex, newText.length);

    /// if selection is right after an inserted character, it should be moved
    /// backward, this adjustment prevents an issue that user cannot delete
    /// characters when cursor stands right after inserted characters
    if (selectionIndex - 1 >= 0 &&
        selectionIndex - 1 < newText.length &&
        !_isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
      text: newText.toPersianNumber,
      selection: TextSelection.collapsed(offset: selectionIndex),
      composing: TextRange.empty,
    );
  }

  TextEditingValue _formatValue(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return _digitOnlyFormatter.formatEditUpdate(oldValue, newValue);
  }

  bool _isUserInput(String s) {
    return _digitOnlyRegex.firstMatch(s) != null;
  }

  String _formatPattern(String digits) {
    final number = int.tryParse(digits.clearFormat);
    if (number == null) return digits;
    final formatter = NumberFormat.decimalPattern('en');
    return formatter.format(number);
  }
}
