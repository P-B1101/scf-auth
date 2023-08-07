import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scf_auth/core/utils/extensions.dart';

import '../../utils/assets.dart';
import '../../utils/ui_utils.dart';

class MInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final Function(String)? onTextChange;
  final Function(String)? onSubmit;
  final FocusNode? nextFocusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Color? inputColor;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? borderColor;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final double borderWidth;
  final Color? hintColor;
  final Color? textColor;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool useHint;
  final String? error;
  final bool closeKeyboardOnFinish;
  final bool isUsernameOrPassword;
  final bool isPassword;
  final bool isEnable;
  final Iterable<String>? autofillHints;
  const MInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.onTextChange,
    this.nextFocusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputColor,
    this.prefixWidget,
    this.borderColor,
    this.onSubmit,
    this.contentPadding,
    this.hintColor,
    this.textColor,
    this.suffixWidget,
    this.inputFormatters,
    this.maxLength,
    this.autofillHints = const <String>[],
    this.enabled = true,
    this.borderWidth = 1,
    this.textAlign = TextAlign.start,
    this.useHint = false,
    this.error,
    this.closeKeyboardOnFinish = true,
    this.isUsernameOrPassword = false,
    this.isPassword = false,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    final defaultAction =
        nextFocusNode == null ? TextInputAction.done : TextInputAction.next;
    final action = textInputAction ?? defaultAction;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            AnimatedOpacity(
              duration: UiUtils.duration,
              curve: UiUtils.curve,
              opacity: isEnable ? 1 : .5,
              child: AbsorbPointer(
                absorbing: !isEnable,
                child: TextField(
                  autofillHints: autofillHints,
                  obscureText: isPassword,
                  enabled: enabled,
                  readOnly: !isEnable,
                  controller: controller,
                  cursorColor: Theme.of(context).textTheme.bodyLarge?.color,
                  keyboardType: keyboardType,
                  focusNode: focusNode,
                  textInputAction: action,
                  inputFormatters: inputFormatters,
                  maxLength: maxLength,
                  textAlign: textAlign,
                  textAlignVertical: TextAlignVertical.center,
                  onSubmitted: (value) {
                    if (nextFocusNode != null) nextFocusNode?.requestFocus();
                    onSubmit?.call(value);
                  },
                  style: TextStyle(
                    fontFamily:
                        isUsernameOrPassword || isPassword ? null : Fonts.yekan,
                    color: textColor ?? MColors.inputTextColorOf(context),
                    fontSize: 14,
                    fontWeight: Fonts.medium500,
                  ),
                  onChanged: (value) {
                    onTextChange?.call(value);
                    if (maxLength != null &&
                        value.length >= maxLength! &&
                        closeKeyboardOnFinish) {
                      focusNode.unfocus();
                    }
                  },
                  buildCounter: (
                    context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) =>
                      null,
                  cursorOpacityAnimates: true,
                  textDirection: isUsernameOrPassword || isPassword
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  decoration: InputDecoration(
                    errorText: null,
                    isDense: true,
                    errorMaxLines: 1,
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(
                      fontFamily: Fonts.yekan,
                      fontSize: 12,
                      fontWeight: Fonts.medium500,
                      color: hintColor ?? MColors.inputHintTextColorOf(context),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: Fonts.yekan,
                      fontSize: 12,
                      fontWeight: Fonts.medium500,
                      color: hintColor ?? MColors.inputHintTextColorOf(context),
                    ),
                    hintMaxLines: 1,
                    labelText: useHint ? null : hint.toPersianNumber,
                    hintText: useHint ? hint.toPersianNumber : null,
                    filled: true,
                    fillColor: inputColor ??
                        MColors.inputFillColorOf(context).withOpacity(.3),
                    contentPadding: contentPadding ??
                        EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal:
                              prefixWidget != null || suffixWidget != null
                                  ? 58
                                  : 16,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: borderColor ??
                            MColors.inputBorderColorOf(context).withOpacity(.3),
                        width: borderWidth,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: borderColor ??
                            MColors.inputBorderColorOf(context).withOpacity(.3),
                        width: borderWidth,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: borderColor ?? MColors.primaryColor,
                        width: borderWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (prefixWidget != null)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: prefixWidget,
              ),
            if (suffixWidget != null)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: suffixWidget,
              ),
          ],
        ),
        AnimatedCrossFade(
          duration: UiUtils.duration,
          sizeCurve: Curves.ease,
          firstCurve: Curves.ease,
          secondCurve: Curves.ease,
          crossFadeState:
              _hasError ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: _errorWidget,
          secondChild: const SizedBox(width: double.infinity),
        ),
      ],
    );
  }

  Widget get _errorWidget => Builder(
        builder: (context) => Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 8, right: 8, top: 6),
          child: Text(
            error?.toPersianNumber ?? '',
            style: const TextStyle(
              fontWeight: Fonts.medium500,
              fontSize: 12,
              color: MColors.redColor,
            ),
          ),
        ),
      );

  bool get _hasError => error != null && error!.isNotEmpty;
}
