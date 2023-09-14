import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateNewPassword.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/ForgotPassword.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/text_span_bold.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class VerifyEmailByOTP extends StatefulWidget {
  static const String routeName = '/verify_email_by_otp';
  final Object? arguments;
  const VerifyEmailByOTP({
    super.key,
    this.arguments,
  });

  @override
  State<VerifyEmailByOTP> createState() => _VerifyEmailByOTPState();
}

class _VerifyEmailByOTPState extends State<VerifyEmailByOTP> {
  // Object? response;
  // _VerifyEmailByOTPState({this.response});
  final NavigationService _navigationService = locator<NavigationService>();
  String isFrom = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var params = (widget.arguments as Map);
    isFrom = params["isFrom"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(children: [
                const OnBoardingHeader(
                  title: 'Enter Verification Code',
                  subTitle:
                      'Enter the 6 digits code that you received on\nyour email.',
                ),
                const SizedBox(
                  height: 48,
                ),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width / 1.1,
                  fieldWidth: 50,
                  style: AppTheme.body1,
                  otpFieldStyle: OtpFieldStyle(
                      backgroundColor: AppClr.otpBackground,
                      focusBorderColor: AppClr.blue),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 10,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                TextSpanBold(
                    title: 'Didn’t receive any code?  ',
                    boldText: 'Resend OTP',
                    onClick: () {}),
              ]),
            ),
            ButtonPrimary(
              title: "Continue",
              onClick: () => {
                if (isFrom == ForgotPassword.routeName)
                  {
                    _navigationService
                        .navigateWithBack(CreateNewPassword.routeName)
                  }
                else
                  {
                    _navigationService
                        .navigateWithRemovingAllPrevious(HomePage.routeName)
                  }
              },
            )
          ],
        ),
      ),
    );
  }
}
