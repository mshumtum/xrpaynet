import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/forgot_password_cubit.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/verify_email_cubit.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/ForgotPassword';

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final NavigationService _navigationService = locator<NavigationService>();
  final ForgotPasswordCubit _forgotCubit = locator<ForgotPasswordCubit>();
  String emailAddress = "";
  bool isValid() {
    return isEmailValid(emailAddress);
  }

  void hitSendOtp() {
    if (isValid()) {
      _forgotCubit.sendEmailVerifyOTP(
        email: emailAddress,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, BaseState>(
          bloc: _forgotCubit,
          listener: (context, state) async {
            if (state.main.isFailure) {
              showError(context, state.main.errorMessage ?? '');
            }
            if (state.main.isInProgress) {
              showLoadingBar(context, "Loading...");
            }
            if (state.main.isOtpSent) {
              showSuccess(context, "OTP sent successfully.");

              _navigationService.navigateWithBack(VerifyEmailByOTP.routeName,
                  arguments: {
                    "isFrom": ForgotPassword.routeName,
                    "email": emailAddress
                  });
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppClr.black,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: ClassMediaQuery.screenHeight / 1.1,
                      child: Column(children: [
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
                          inputType: TextInputType.emailAddress,
                          onChangeText: (value) {
                            setState(() {
                              emailAddress = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ]),
                    ),
                    // Expanded(child: Container()),
                    ButtonPrimary(
                      title: "Send OTP",
                      onClick: () {
                        hitSendOtp();
                      },
                      buttonColor: isValid() ? AppClr.blue : AppClr.greyButton,
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
