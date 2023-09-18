import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/ForgotPassword';

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ClassMediaQuery.screenHeight / 1.25,
              child: const Column(children: [
                OnBoardingHeader(
                  title: 'Forgot Password',
                  subTitle:
                      'Enter your email for the verification process,\n we will send 6 digits code to your email.',
                ),
                SizedBox(
                  height: 48,
                ),
                InputField(
                    inputLabel: "Email",
                    hintText: 'Enter Email',
                    inputType: TextInputType.emailAddress),
                SizedBox(
                  height: 18,
                ),
              ]),
            ),
            SizedBox(
              height: ClassMediaQuery.pendingContainerHeight(1.25),
              child: ButtonPrimary(
                title: "Send OTP",
                onClick: () {
                  _navigationService.navigateWithBack(
                      VerifyEmailByOTP.routeName,
                      arguments: {"isFrom": ForgotPassword.routeName});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
