import 'package:flutter/material.dart';

class Fonts {
  const Fonts._();
  static const yekan = "Yekan";
  static const knewave = 'Knewave';
  static const icomoon = 'Icomoon';
  static const bold700 = FontWeight.w700;
  static const medium500 = FontWeight.w500;
  static const regular400 = FontWeight.w400;

  static const profile = IconData(0xe900, fontFamily: icomoon);
  static const arrowDown = IconData(0xe901, fontFamily: icomoon);
  static const plus = IconData(0xe902, fontFamily: icomoon);
  static const trash = IconData(0xe903, fontFamily: icomoon);
  static const upload = IconData(0xe904, fontFamily: icomoon);
}

class MColors {
  const MColors._();

  static const primaryColor = Color(0xFF017874);
  static const secondryColor = Color(0xFFF37135);
  static const fontLogoColorStart = Color(0xFF009456);
  static const splashStartColor = Color(0xFFB2D7D6);
  static const bottomNavigationNotSelectedColor = Color(0xFFACACB0);
  static const personalWalletStartColor = Color(0xFF1ACDC7);
  static const bottomSheetAnchorColor = Color(0xFFACACB0);
  static const redColor = Color(0xFFFF3535);
  static const greenColor = Color(0xFF0AD059);
  static const successColor = Color(0xFF179b4c);
  static const disableButtonTextColor = Color(0XFFB2D7D6);
  static const failurePaymentColor = Color(0xFFFF3535);
  static const successPaymentColor = Color(0xFF009456);
  static const errorColor = Color(0xFFD40000);
  static const toastErrorColor = Color(0xFFD92020);

  /// Light
  static const primaryLightColor = Color(0xFFE0FFF8);
  static const primaryWhiteColor = Color(0xFFEAF2F2);
  static const primaryWhiteColor2 = Color(0xFFD3D9DB);
  static const primaryWhiteColor3 = Color(0xFFFCFCFC);
  static const primaryTextColor = Color(0xFF434343);
  static const walkThroughTitleColor = Color(0xFF030319);
  static const walkThroughDescriptionColor = Color(0xFF48484A);
  static const bottomNavigationDividerColor = Color(0xFFEAEBED);
  static const walletColorStart = Color(0xFFF09266);
  static const walletColorEnd = Color(0xFFF4783E);
  static const featureBoxColor = Color(0xFFFFFFFF);
  static const featureBoxTextColor = Color(0XFF1E1E20);
  static const walletBottomSheetColor = Color(0xFFF9F9F9);
  static const walletFeatureBoxColor = Color(0xFFDEDFE1);
  static const walletFeatureTextColor = Color(0XFF1E1E20);
  static const transactionTitleColor = Color(0xFF2C2C2C);
  static const inputTextColor = Color(0xFF2C2C2C);
  static const inputHintTextColor = Color(0xFFACACB0);
  static const inputBorderFocusedColor = Color(0XFF434343);
  static const inputBorderColor = Color(0xFF959595);
  static const inputFillColor = Color(0XFFFFFFFF);
  static const titleColor = Color(0xFF2C2C2C);
  static const bottomSheetColor = Color(0XFFEAF2F2);
  static const dialogBackgroundColor = Color(0xFFFDFFFF);
  static const buttonTextColor = Color(0xFFE0FFF8);
  static const indicatorBackgroundColor = Color(0xFFD9D9D9);
  static const indicatorUnSelectedCircleColor = Color(0xFFDEDFE1);
  static const indicatorSelectedCircleColor = Color(0xFFFFFFFF);

  /// Dark
  static const primaryDarkColor = Color(0xFF315453);
  static const primaryBlackColor = Color(0xFF293434);
  static const primaryBlackColor2 = Color(0xFF4E5354);
  static const primaryBlackColor3 = Color(0xFFFCFCFC);
  static const primaryDarkTextColor = Color(0xFFFCFCFC);
  static const walkThroughTitleDarkColor = Color(0xFFFAFAFE);
  static const walkThroughDescriptionDarkColor = Color(0xFFE3E3E3);
  static const bottomNavigationColor = Color(0xFF242424);
  static const bottomNavigationDividerDarkColor = Color(0xFF394343);
  static const walletDarkColorStart = Color(0xFFF2996F);
  static const walletDarkColorEnd = Color(0xFFF37135);
  static const personalWalletIconColor = Color(0XFF03807C);
  static const featureBoxDarkColor = Color(0xFF394343);
  static const featureBoxTextDarkColor = Color(0XFFFFFFFF);
  static const walletBottomSheetDarkColor = Color(0xFF3D3D3D);
  static const walletFeatureBoxDarkColor = Color(0xFF333333);
  static const walletFeatureTextDarkColor = Color(0xFFFFFFFF);
  static const inputTextDarkColor = Color(0xFFFFFFFF);
  static const inputHintTextDarkColor = Color(0xFFE3E3E3);
  static const inputBorderFocusedDarkColor = Color(0XFFFFFFFF);
  static const inputBorderDarkColor = Color(0xFF959595);
  static const inputFillDarkColor = Color(0xFF315453);
  static const titleDarkColor = Color(0xFFFCFCFC);
  static const bottomSheetDarkColor = Color(0XFF3D3D3D);
  static const dialogBackgroundDarkColor = Color(0xFF293434);
  static const buttonTextDarkColor = Color(0xFFFFFFFF);
  static const indicatorBackgroundDarkColor = Color(0xFFD9D9D9);
  static const indicatorUnSelectedCircleDarkColor = Color(0xFFDEDFE1);
  static const indicatorSelectedCircleDarkColor = Color(0xFFFFFFFF);

  static Color textColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryDarkTextColor;
      case Brightness.light:
        return MColors.primaryTextColor;
    }
  }

  static Color selectedAuthTypeTextColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryDarkTextColor;
      case Brightness.light:
        return MColors.primaryDarkTextColor;
    }
  }

  static Color textColor2Of(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return Colors.white;
      case Brightness.light:
        return Colors.black;
    }
  }

  static Color primaryLightOrDarkColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryDarkColor;
      case Brightness.light:
        return MColors.primaryLightColor;
    }
  }

  static Color primaryBlackOrWhiteColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryBlackColor;
      case Brightness.light:
        return MColors.primaryWhiteColor;
    }
  }

  static Color primaryBlackOrWhiteColor2Of(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryBlackColor2;
      case Brightness.light:
        return MColors.primaryWhiteColor2;
    }
  }

  static Color primaryBlackOrWhiteColor3Of(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryBlackColor3;
      case Brightness.light:
        return MColors.primaryWhiteColor3;
    }
  }

  static Color reversePrimaryBlackOrWhiteColor2Of(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryWhiteColor2;
      case Brightness.light:
        return MColors.primaryBlackColor2;
    }
  }

  static Color splashStartColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryDarkColor;
      case Brightness.light:
        return MColors.splashStartColor;
    }
  }

  static Color walkThroughTitleColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.walkThroughTitleDarkColor;
      case Brightness.light:
        return MColors.walkThroughTitleColor;
    }
  }

  static Color walkThroughDescriptionColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.walkThroughDescriptionDarkColor;
      case Brightness.light:
        return MColors.walkThroughDescriptionColor;
    }
  }

  static Color bottomNavigationColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.bottomNavigationColor.withOpacity(.64);
      case Brightness.light:
        return MColors.primaryDarkTextColor.withOpacity(.64);
    }
  }

  static Color bottomNavigationDividerColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.bottomNavigationDividerDarkColor;
      case Brightness.light:
        return MColors.bottomNavigationDividerColor.withOpacity(.8);
    }
  }

  static Color walletStartColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.walletDarkColorStart;
      case Brightness.light:
        return MColors.walletColorStart;
    }
  }

  static Color walletEndColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.walletDarkColorEnd;
      case Brightness.light:
        return MColors.walletColorEnd;
    }
  }

  static Color personalWalletStartColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.personalWalletStartColor;
      case Brightness.light:
        return MColors.personalWalletStartColor;
    }
  }

  static Color personalWalletEndColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryColor;
      case Brightness.light:
        return MColors.primaryColor;
    }
  }

  static Color personalWalletIconColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.personalWalletIconColor;
      case Brightness.light:
        return MColors.primaryColor;
    }
  }

  static Color featureBoxColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.featureBoxDarkColor;
      case Brightness.light:
        return MColors.featureBoxColor;
    }
  }

  static Color featureBoxTextColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.featureBoxTextDarkColor;
      case Brightness.light:
        return MColors.featureBoxTextColor;
    }
  }

  static Color walletBottomSheetColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.walletBottomSheetDarkColor;
      case Brightness.light:
        return MColors.walletBottomSheetColor;
    }
  }

  static Color walletFeatureBoxColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.walletFeatureBoxDarkColor;
      case Brightness.light:
        return MColors.walletFeatureBoxColor;
    }
  }

  static Color walletFeatureTextColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.walletFeatureTextDarkColor;
      case Brightness.light:
        return MColors.walletFeatureTextColor;
    }
  }

  static Color transactionTitleColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryDarkTextColor;
      case Brightness.light:
        return MColors.transactionTitleColor;
    }
  }

  static Color inputTextColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.inputTextDarkColor;
      case Brightness.light:
        return MColors.inputTextColor;
    }
  }

  static Color inputHintTextColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.inputHintTextDarkColor;
      case Brightness.light:
        return MColors.inputHintTextColor;
    }
  }

  static Color inputBorderFocusedColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.inputBorderFocusedDarkColor;
      case Brightness.light:
        return MColors.inputBorderFocusedColor;
    }
  }

  static Color inputBorderColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.inputBorderDarkColor;
      case Brightness.light:
        return MColors.inputBorderColor;
    }
  }

  static Color inputFillColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.inputFillDarkColor;
      case Brightness.light:
        return MColors.inputFillColor;
    }
  }

  static Color transactionsDividerColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return Colors.white.withOpacity(.1);
      case Brightness.light:
        return Colors.black.withOpacity(.1);
    }
  }

  static Color bottomSheetAnchorColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.bottomSheetAnchorColor;
      case Brightness.light:
        return MColors.bottomSheetAnchorColor.withOpacity(.24);
    }
  }

  static Color titleColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.titleDarkColor;
      case Brightness.light:
        return MColors.titleColor;
    }
  }

  static Color bottomSheetColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.bottomSheetDarkColor;
      case Brightness.light:
        return MColors.bottomSheetColor;
    }
  }

  static Color dialogBackgroundColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.dialogBackgroundDarkColor;
      case Brightness.light:
        return MColors.dialogBackgroundColor;
    }
  }

  static Color buttonTextColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.buttonTextDarkColor;
      case Brightness.light:
        return MColors.buttonTextColor;
    }
  }

  static Color notSelectedAuthTypeColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryBlackColor;
      case Brightness.light:
        return MColors.primaryWhiteColor;
    }
  }

  static Color notSelectedAuthTypeTextColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.primaryWhiteColor2;
      case Brightness.light:
        return MColors.primaryTextColor;
    }
  }

  static Color indicatorBackgroundColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.indicatorBackgroundDarkColor.withOpacity(.5);
      case Brightness.light:
        return MColors.indicatorBackgroundColor.withOpacity(.5);
    }
  }

  static Color indicatorUnSelectedCircleColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.indicatorUnSelectedCircleDarkColor.withOpacity(.8);
      case Brightness.light:
        return MColors.indicatorUnSelectedCircleColor.withOpacity(.8);
    }
  }

  static Color indicatorSelectedCircleColorOf(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return MColors.indicatorSelectedCircleDarkColor;
      case Brightness.light:
        return MColors.indicatorSelectedCircleColor;
    }
  }
}
