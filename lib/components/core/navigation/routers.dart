import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/login/LoginScreen.dart';


class Routers {
  static RouteSettings? _settings;

  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    _settings = settings;

    switch (settings.name) {
      case WelcomeScreen.routeName:
        return _pageRoute(builder: (context) {
          return const WelcomeScreen();
        });
      case LoginPage.routeName:
        return _pageRoute(builder: (context) {
          return const LoginPage();
        });

      default:
        throw Exception('Route Not Found');
    }
  }

  static _pageRoute({required WidgetBuilder builder, bool showModal = false}) {
    if (Platform.isAndroid) {
      return MaterialPageRoute(
        builder: builder,
        settings: _settings,
      );
    } else if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: builder,
        settings: _settings,
        fullscreenDialog: showModal,
      );
    }
  }
}
