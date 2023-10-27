import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(Constants.accessToken);
      print("token$token");
      if (token == null || token == "") {
        _navigationService
            .navigateWithRemovingAllPrevious(WelcomeScreen.routeName);
      } else {
        Constants.userAccessToken = token;
        _navigationService.navigateWithRemovingAllPrevious(HomePage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: Center(
        child: Image.asset(
          Images.icVolta,
          width: 131,
        ),
      ),
    );
  }
}
