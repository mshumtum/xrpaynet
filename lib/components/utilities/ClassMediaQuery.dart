import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// this class have static members which can be accessed by just class name
// this class used to find height width of the device
// we are just creating a instance once so that all the static variable will be allocated memory
class ClassMediaQuery {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late bool isDark;
  static late double notchHeight;

  static double pendingContainerHeight(height) {
    var a = screenHeight - screenHeight / height;
    return a;
  }

  ClassMediaQuery(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height -
        (_mediaQueryData.padding.top + _mediaQueryData.padding.bottom);

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    notchHeight = _mediaQueryData.padding.top;
    isDark = _mediaQueryData.platformBrightness == Brightness.dark;
  }
}

class CommonSnackBar {}
