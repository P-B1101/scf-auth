import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/enums.dart';

import '../../utils/assets.dart';
import '../../utils/ui_utils.dart';
import '../loading/adaptive_loading_widget.dart';

class MButtonWidget extends StatelessWidget {
  final Function() onClick;
  final String title;
  final bool isEnable;
  final bool enableClickWhenDisable;
  final FontWeight? textWeight;
  final bool isLoading;
  final double? width;
  final ButtonType type;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  const MButtonWidget({
    super.key,
    required this.onClick,
    required this.title,
    this.isEnable = true,
    this.enableClickWhenDisable = true,
    this.textWeight,
    this.isLoading = false,
    this.width,
    this.type = ButtonType.fill,
    this.child,
    this.color,
    this.padding,
  });

  factory MButtonWidget.outline({
    required Function() onClick,
    required String title,
    bool isEnable = true,
    bool enableClickWhenDisable = true,
    FontWeight? textWeight,
    bool isLoading = false,
    double? width,
  }) =>
      MButtonWidget(
        onClick: onClick,
        title: title,
        enableClickWhenDisable: enableClickWhenDisable,
        isEnable: isEnable,
        isLoading: isLoading,
        type: ButtonType.outline,
        textWeight: textWeight,
        width: width,
      );

  factory MButtonWidget.text({
    required Function() onClick,
    required String title,
    bool isEnable = true,
    bool enableClickWhenDisable = true,
    FontWeight? textWeight,
    bool isLoading = false,
    Color? color,
    double? width,
    EdgeInsetsGeometry? padding,
  }) =>
      MButtonWidget(
        onClick: onClick,
        title: title,
        enableClickWhenDisable: enableClickWhenDisable,
        isEnable: isEnable,
        isLoading: isLoading,
        type: ButtonType.text,
        textWeight: textWeight,
        width: width,
        color: color,
        padding: padding,
      );

  factory MButtonWidget.textWithIcon({
    required Function() onClick,
    required Widget child,
    bool isEnable = true,
    bool enableClickWhenDisable = true,
    FontWeight? textWeight,
    bool isLoading = false,
    double? width,
  }) =>
      MButtonWidget(
        onClick: onClick,
        title: '',
        enableClickWhenDisable: enableClickWhenDisable,
        isEnable: isEnable,
        isLoading: isLoading,
        type: ButtonType.textAndIcon,
        textWeight: textWeight,
        width: width,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: UiUtils.duration,
      curve: UiUtils.curve,
      opacity: isEnable ? 1 : .5,
      child: Container(
        width: width,
        height: () {
          switch (type) {
            case ButtonType.textAndIcon:
            case ButtonType.text:
              return null;
            case ButtonType.fill:
            case ButtonType.outline:
              return 54.0;
          }
        }(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: () {
            switch (type) {
              case ButtonType.fill:
                return color ?? MColors.primaryColor;
              case ButtonType.outline:
              case ButtonType.text:
              case ButtonType.textAndIcon:
                return null;
            }
          }(),
          border: Border.all(
            color: color ?? MColors.primaryColor,
            width: 1,
            style: () {
              switch (type) {
                case ButtonType.outline:
                  return BorderStyle.solid;
                case ButtonType.fill:
                case ButtonType.text:
                case ButtonType.textAndIcon:
                  return BorderStyle.none;
              }
            }(),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: _canClick ? onClick : null,
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: () {
                switch (type) {
                  case ButtonType.outline:
                  case ButtonType.text:
                  case ButtonType.fill:
                    return Center(child: _finalChildWidget);
                  case ButtonType.textAndIcon:
                    return _finalChildWidget;
                }
              }(),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _finalChildWidget => Builder(
        builder: (context) => AnimatedCrossFade(
          duration: UiUtils.duration,
          sizeCurve: UiUtils.curve,
          firstCurve: UiUtils.curve,
          secondCurve: UiUtils.curve,
          crossFadeState:
              isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: () {
            switch (type) {
              case ButtonType.outline:
              case ButtonType.text:
              case ButtonType.fill:
                return _titleWidget;
              case ButtonType.textAndIcon:
                return child ?? _titleWidget;
            }
          }(),
          secondChild: const Center(
            child: AdaptiveLoadingWidget(
              color: MColors.primaryDarkTextColor,
            ),
          ),
        ),
      );

  Widget get _titleWidget => Builder(
        builder: (context) => AnimatedSwitcher(
          duration: UiUtils.duration,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: AnimatedDefaultTextStyle(
            key: ValueKey(title),
            duration: UiUtils.duration,
            curve: UiUtils.curve,
            style: TextStyle(
              fontFamily: Fonts.yekan,
              color: isEnable
                  ? () {
                      switch (type) {
                        case ButtonType.outline:
                        case ButtonType.text:
                        case ButtonType.textAndIcon:
                          return color ?? MColors.primaryColor;
                        case ButtonType.fill:
                          return MColors.buttonTextColorOf(context);
                      }
                    }()
                  : MColors.disableButtonTextColor,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: textWeight ?? Fonts.regular400,
              ),
            ),
          ),
        ),
      );

  bool get _canClick => !isLoading && (isEnable || enableClickWhenDisable);
}
