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

  static double containerHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: AppClr.white,
  );
  static const TextStyle white40 = TextStyle(
    fontFamily: fontMedium,
    fontSize: 40,
    letterSpacing: 1.16,
    color: AppClr.white,
  );

  static const TextStyle resendGreyText14 = TextStyle(
    fontFamily: fontRegular,
    fontSize: 14,
    color: AppClr.resendGreyText,
  );
  static const TextStyle white14Bold = TextStyle(
    fontFamily: fontBold,
    fontSize: 14,
    color: AppClr.white,
  );
}
