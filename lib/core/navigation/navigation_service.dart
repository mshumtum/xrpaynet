import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/utilities/utility.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateWithBack(String routeName, {var arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateWithNoBack(String routeName, {var arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateWithRemovingAllPrevious(String routeName,
      {var arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  goBack() {
    if (navigatorKey.currentState!.canPop()) {
      return navigatorKey.currentState!.pop();
    } else {
      return navigateWithRemovingAllPrevious(WelcomeScreen.routeName);
    }
  }
}
