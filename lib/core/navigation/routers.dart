import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LSPFeeByLockXRP.dart';
import 'package:xr_paynet/components/screens/activationFeesScreens/LifeStylePlusFees.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/ActiveVirtualCards.dart';
import 'package:xr_paynet/components/screens/appliedCardScreens/LifeStylePlusApplied.dart';
import 'package:xr_paynet/components/screens/card_recharge/CardRecharge.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/ApplyPhysicalCardForm.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/LifeStylePlusApply.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/VirtualCardApply.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/LifeStylePlusCards.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/ApplyVirtualCardForm.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCurrency.dart';
import 'package:xr_paynet/components/screens/deposit/Deposit.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LifeStylePlusKYC.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LspSuccessScreen.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/_link_card.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateAccount.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateNewPassword.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/ForgotPassword.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';
import 'package:xr_paynet/components/screens/transaction_history/TransactionHistory.dart';

class Routers {
  static RouteSettings? _settings;

  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

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
          return VerifyEmailByOTP(
            arguments: arguments,
          );
        });
      case ForgotPassword.routeName:
        return _pageRoute(builder: (context) {
          return const ForgotPassword();
        });
      case CreateNewPassword.routeName:
        return _pageRoute(builder: (context) {
          return CreateNewPassword(arguments: arguments);
        });
      case HomePage.routeName:
        return _pageRoute(builder: (context) {
          return const HomePage();
        });
      case ChooseCurrency.routeName:
        return _pageRoute(builder: (context) {
          return const ChooseCurrency();
        });
      case Deposit.routeName:
        return _pageRoute(builder: (context) {
          return Deposit(
            arguments: arguments.toString(),
          );
        });
      case ApplyVirtualCardForm.routeName:
        return _pageRoute(builder: (context) {
          return ApplyVirtualCardForm(arguments: arguments);
        });
      case ApplyPhysicalCardForm.routeName:
        return _pageRoute(builder: (context) {
          return ApplyPhysicalCardForm(
            arguments: arguments.toString(),
          );
        });
      case TransactionHistory.routeName:
        return _pageRoute(builder: (context) {
          return const TransactionHistory();
        });
      case VirtualCardApply.routeName:
        return _pageRoute(builder: (context) {
          return VirtualCardApply(
            arguments: arguments,
          );
        });
      case LifeStylePlusFees.routeName:
        return _pageRoute(builder: (context) {
          return LifeStylePlusFees(
            arguments: arguments,
          );
        });
      case LifeStylePlusApplied.routeName:
        return _pageRoute(builder: (context) {
          return LifeStylePlusApplied(
            arguments: arguments,
          );
        });
      case ActiveVirtualCards.routeName:
        return _pageRoute(builder: (context) {
          return ActiveVirtualCards(
            arguments: arguments,
          );
        });
      case LSPFeeByLockXRP.routeName:
        return _pageRoute(builder: (context) {
          return LSPFeeByLockXRP(
            arguments: arguments,
          );
        });
      case LinkCard.routeName:
        return _pageRoute(builder: (context) {
          return LinkCard(
            arguments: arguments,
          );
        });
      case LifeStylePlusKYC.routeName:
        return _pageRoute(builder: (context) {
          return LifeStylePlusKYC(
            arguments: arguments,
          );
        });
      case CardRecharge.routeName:
        return _pageRoute(builder: (context) {
          return CardRecharge(
            arguments: arguments,
          );
        });
      case LifeStylePlusCards.routeName:
        return _pageRoute(builder: (context) {
          return const LifeStylePlusCards();
        });
      case LifeStylePlusApply.routeName:
        return _pageRoute(builder: (context) {
          return const LifeStylePlusApply();
        });
      case LspSuccessScreen.routeName:
        return _pageRoute(builder: (context) {
          return LspSuccessScreen(
            arguments: arguments,
          );
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
