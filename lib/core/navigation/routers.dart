import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateAccount.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/ForgotPassword.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';

class Routers {
  static RouteSettings? _settings;

  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    _settings = settings;

    switch (settings.name) {
      case WelcomeScreen.routeName:
        return _pageRoute(builder: (context) {
          return const WelcomeScreen();
        });
      case CreateAccount.routeName:
        return _pageRoute(builder: (context) {
          return const CreateAccount();
        });
      case LoginScreen.routeName:
        return _pageRoute(builder: (context) {
          return const LoginScreen();
        });
      case VerifyEmailByOTP.routeName:
        return _pageRoute(builder: (context) {
          return const VerifyEmailByOTP();
        });
      case ForgotPassword.routeName:
        return _pageRoute(builder: (context) {
          return const ForgotPassword();
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