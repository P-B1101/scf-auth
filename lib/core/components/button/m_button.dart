import 'package:flutter/material.dart';

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
  const MButtonWidget({
    super.key,
    required this.onClick,
    required this.title,
    this.isEnable = true,
    this.enableClickWhenDisable = true,
    this.textWeight,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: UiUtils.duration,
      curve: UiUtils.curve,
      opacity: isEnable ? 1 : .5,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: MColors.primaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _canClick ? onClick : null,
            child: Center(
              child: AnimatedCrossFade(
                duration: UiUtils.duration,
                sizeCurve: UiUtils.curve,
                firstCurve: UiUtils.curve,
                secondCurve: UiUtils.curve,
                crossFadeState: isLoading
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: _titleWidget,
                secondChild: const Center(
                  child: AdaptiveLoadingWidget(
                    color: MColors.primaryDarkTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
                  ? MColors.buttonTextColorOf(context)
                  : MColors.disableButtonTextColor,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: textWeight ?? Fonts.medium500,
              ),
            ),
          ),
        ),
      );

  bool get _canClick => !isLoading && (isEnable || enableClickWhenDisable);
}
