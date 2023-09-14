import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateAccount.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Constants.dart';
import 'package:xr_paynet/theme/Images.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome_page';
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        right: 0,
                        left: 0,
                        top: -70,
                        child: Image.asset(Images.ic_volta),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
                        child: Image.asset(
                          Images.ic_welcome_bg,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset(Images.ic_welcome_cards),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    Constants.welcomeText,
                    style: AppTheme.white40,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  ButtonPrimary(
                    title: "Create Your Account",
                    onClick: () {
                      _navigationService
                          .navigateWithBack(CreateAccount.routeName);
                    },
                  ),
                  const SizedBox(height: 14),
                  ButtonSecondary(
                    title: "Account Already Exists",
                    onClick: () {
                      _navigationService
                          .navigateWithBack(LoginScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ));
    // Container(
    //     padding: EdgeInsets.fromLTRB(35.0, 25.0, 35.0, 30.0),
    //     child: Column(children: [Header()])));
  }
}
