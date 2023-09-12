import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/Colors.dart';

class AppTheme {
  // AppTheme._();

  static const String fontFamily = 'Roboto';
  static const String fontMedium = 'Roboto-Medium';

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
    color: AppClr.dark,
  );
  static const TextStyle white40 = TextStyle(
    fontFamily: fontMedium,
    fontSize: 40,
    letterSpacing: 1.16,
    color: AppClr.white,
  );
}
