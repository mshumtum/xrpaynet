import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/Colors.dart';

class AppTheme {
  // AppTheme._();

  static const String fontFamily = 'Roboto';
  static const String fontMedium = 'Roboto-Medium';
  static const String fontBold = 'Roboto-Bold';
  static const String fontRegular = 'Roboto-fontRegular';
  static const String fontLight = 'Roboto-Light';

  static MaterialColor black = const MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFFe0e0e0),
      100: Color(0xFFb3b3b3),
      200: Color(0xFF808080),
      300: Color(0xFF4d4d4d),
      400: Color(0xFF262626),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const _blackPrimaryValue = 0xFF000000;

  static const TextStyle white16w500 = TextStyle(
    // body2 -> body1
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.05,
    color: AppClr.white,
  );
  static const TextStyle white40 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.16,
    color: AppClr.white,
  );

  static const TextStyle resendGreyText14 = TextStyle(
    fontFamily: fontRegular,
    fontSize: 14,
    color: AppClr.resendGreyText,
  );
  static const TextStyle resendGreyText16 = TextStyle(
    fontFamily: fontRegular,
    fontSize: 16,
    color: AppClr.resendGreyText,
  );
  static const TextStyle resendGreyText18 = TextStyle(
    fontFamily: fontRegular,
    fontSize: 18,
    color: AppClr.resendGreyText,
  );
  static const TextStyle white14Bold = TextStyle(
    fontFamily: fontBold,
    fontSize: 14,
    color: AppClr.white,
  );
  static const TextStyle white14Regular = TextStyle(
    fontFamily: fontRegular,
    fontSize: 14,
    color: AppClr.white,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle white14Regular22 = TextStyle(
    fontFamily: fontRegular,
    fontSize: 14,
    color: AppClr.white,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  static const TextStyle greyWhite14Regular22 = TextStyle(
    fontFamily: fontRegular,
    fontSize: 14,
    color: AppClr.greyWhite,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  static const TextStyle greyText14Regular = TextStyle(
    fontFamily: fontRegular,
    fontSize: 14,
    color: AppClr.greyText,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle white18Medium = TextStyle(
    fontFamily: fontMedium,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppClr.white,
  );
  static const TextStyle greyWhite16Regular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppClr.greyWhite,
  );
  static const TextStyle white11Bold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 11,
    color: AppClr.white,
    fontFamily: fontBold,
  );
  static const TextStyle black12Bold = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: AppClr.black,
    fontFamily: fontBold,
  );
  static const TextStyle black16Regular = TextStyle(
    fontSize: 16,
    color: AppClr.black,
    fontFamily: fontRegular,
  );
  static const TextStyle black10Regular = TextStyle(
    fontSize: 10,
    color: AppClr.black,
    fontFamily: fontRegular,
  );
  static const TextStyle white24Regular = TextStyle(
    fontSize: 24,
    color: AppClr.white,
    fontFamily: fontRegular,
  );
  static const TextStyle white18Regular = TextStyle(
    fontSize: 18,
    color: AppClr.white,
    fontFamily: fontRegular,
  );
  static const TextStyle white16Regular = TextStyle(
    fontSize: 16,
    color: AppClr.white,
    fontFamily: fontRegular,
  );
  static const TextStyle lightBlueText20Regular = TextStyle(
    fontSize: 20,
    color: AppClr.lightBlueText,
    fontFamily: fontRegular,
  );
  static BoxDecoration selectedCardXrPay = BoxDecoration(
    gradient: const LinearGradient(
      colors: [AppClr.blue_gradient, AppClr.black_gradient],
      // Replace with your desired colors
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      transform: GradientRotation(182), // Convert degrees to radians
    ),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(color: AppClr.selectedCardBorder, spreadRadius: 1),
    ],
  );

  static BoxDecoration unselectedCardXrPay = BoxDecoration(
    gradient: const LinearGradient(
      colors: [AppClr.unselectedCardGradient1, AppClr.unselectedCardGradient2],
      // Replace with your desired colors
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      transform: GradientRotation(182), // Convert degrees to radians
    ),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(color: AppClr.selectedCardBorder, spreadRadius: 1),
    ],
  );
}
