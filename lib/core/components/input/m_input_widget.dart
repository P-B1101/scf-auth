import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/assets.dart';
import '../../utils/extensions.dart';
import '../../utils/ui_utils.dart';

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

  bool get isEmpty => text.isEmpty;
}

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
  final bool isReadOnly;
  final double? height;
  final bool isMultiLine;

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
    this.useHint = true,
    this.error,
    this.closeKeyboardOnFinish = true,
    this.isUsernameOrPassword = false,
    this.isPassword = false,
    this.isEnable = true,
    this.isReadOnly = false,
    this.height,
    this.isMultiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultAction =
        nextFocusNode == null ? TextInputAction.done : TextInputAction.next;
    final action = textInputAction ?? defaultAction;
    return BlocProvider<_Cubit>(
      create: (context) => _Cubit(),
      child: Builder(
        builder: (context) => Column(
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
                    absorbing: !isEnable || isReadOnly,
                    child: BlocBuilder<_Cubit, _State>(
                      buildWhen: (previous, current) =>
                          previous.isEmpty != current.isEmpty,
                      builder: (context, state) {
                        final mBorderColor = state.isEmpty
                            ? MColors.inputBorderColorOf(context)
                            : MColors.primaryColor;

                        final mFocusedBorderColor = state.isEmpty
                            ? MColors.inputBorderFocusedColorOf(context)
                            : MColors.primaryColor;
                        final textField = TextField(
                          maxLines: isMultiLine ? null : 1,
                          autofillHints: autofillHints,
                          obscureText: isPassword,
                          enabled: enabled,
                          readOnly: !isEnable || isReadOnly,
                          controller: controller,
                          textAlignVertical: isMultiLine
                              ? TextAlignVertical.top
                              : TextAlignVertical.center,
                          cursorColor:
                              Theme.of(context).textTheme.bodyLarge?.color,
                          keyboardType: isMultiLine
                              ? TextInputType.multiline
                              : keyboardType,
                          focusNode: focusNode,
                          textInputAction:
                              isMultiLine ? TextInputAction.newline : action,
                          inputFormatters: inputFormatters,
                          maxLength: maxLength,
                          textAlign: textAlign,
                          onSubmitted: (value) {
                            if (nextFocusNode != null) {
                              nextFocusNode?.requestFocus();
                            }
                            onSubmit?.call(value);
                          },
                          style: TextStyle(
                            fontFamily: isUsernameOrPassword || isPassword
                                ? null
                                : Fonts.yekan,
                            color:
                                textColor ?? MColors.inputTextColorOf(context),
                            fontSize: 14,
                            fontWeight: Fonts.regular400,
                          ),
                          onChanged: (value) {
                            context.read<_Cubit>().onTextChange(value);
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
                              fontWeight: Fonts.regular400,
                              color: hintColor ??
                                  MColors.inputHintTextColorOf(context),
                            ),
                            labelStyle: TextStyle(
                              fontFamily: Fonts.yekan,
                              fontSize: 12,
                              fontWeight: Fonts.regular400,
                              color: hintColor ??
                                  MColors.inputHintTextColorOf(context),
                            ),
                            hintMaxLines: 1,
                            labelText: useHint ? null : hint.toPersianNumber,
                            hintText: useHint ? hint.toPersianNumber : null,
                            filled: true,
                            fillColor: inputColor ??
                                MColors.inputFillColorOf(context)
                                    .withOpacity(.3),
                            contentPadding: contentPadding ??
                                EdgeInsetsDirectional.only(
                                  top: 20,
                                  bottom: 20,
                                  start: prefixWidget != null ? 48 : 10,
                                  end: suffixWidget != null ? 48 : 10,
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: _hasError
                                    ? MColors.redColor
                                    : borderColor ?? mBorderColor,
                                width: borderWidth,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: _hasError
                                    ? MColors.redColor
                                    : borderColor ?? mBorderColor,
                                width: borderWidth,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: _hasError
                                    ? MColors.redColor
                                    : borderColor ?? mFocusedBorderColor,
                                width: borderWidth,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: borderColor ?? MColors.errorColor,
                                width: borderWidth,
                              ),
                            ),
                          ),
                        );
                        if (height == null) return textField;
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: height!),
                          child: textField,
                        );
                      },
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
              crossFadeState: _hasError
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: _errorWidget,
              secondChild: const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _errorWidget => Builder(
        builder: (context) => Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            error?.toPersianNumber ?? '',
            style: const TextStyle(
              fontWeight: Fonts.regular400,
              fontSize: 12,
              color: MColors.errorColor,
            ),
          ),
        ),
      );

  bool get _hasError => error != null && error!.isNotEmpty;
}
