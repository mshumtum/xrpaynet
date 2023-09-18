import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();

    Future.delayed(const Duration(milliseconds: 3500), () {
      _navigationService.navigateWithBack(WelcomeScreen.routeName);
    });
    return Scaffold(
      backgroundColor: AppClr.black,
      body: Center(
        child: Image.asset(
          Images.ic_volta,
          width: 131,
        ),
      ),
    );
  }
}
