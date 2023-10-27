import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateNewPassword.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/ForgotPassword.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/text_span_bold.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/card_login_cubit/card_login_cubit.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/verify_email_cubit.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

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
  final NavigationService _navigationService = locator<NavigationService>();
  final VerifyEmailCubit _verifyCubit = locator<VerifyEmailCubit>();
  final CardLoginCubit _loginCubit = locator<CardLoginCubit>();
  String isFrom = "",
      userEmail = "",
      otp = "",
      password = "",
      resendText = "Resend OTP";
  var counter = 60;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var params = (widget.arguments as Map);
    isFrom = params["isFrom"];
    userEmail = params["email"];
    password = params?["password"] ?? "";
    timerFunction();
    if (isFrom == "LoginScreen") {
      _verifyCubit.sendEmailVerifyOTP(
        email: userEmail,
      );
    }
  }

  bool isValid(BaseState state) {
    return otp.trim().length == 6 && !state.main.isInProgress;
  }

  void hitApi(BaseState state) {
    if (isValid(state)) {
      _verifyCubit.verifyEmailByOTP(email: userEmail, otp: otp);
    }
  }

  void showDialogFunction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CongratulationDialog(
            title: "Successfully Created",
            descriptions: "Congratulations your account has been created",
            doneTxt: "Done",
            lottieFile: Images.congratulationLottie,
            onClick: () {
              Navigator.of(context).pop();
              _navigationService
                  .navigateWithRemovingAllPrevious(LoginScreen.routeName);
            },
            horizontalMargin: 50,
          );
        });
  }

  void timerFunction() {
    counter = 60;
    setButtonText(counter);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter--;
      setButtonText(counter);
      if (counter == 0) {
        timer.cancel();
        setButtonText(counter);
      }
    });
  }

  setButtonText(counter) {
    var text = "";
    if (counter == 0) {
      text = "Resend OTP";
    } else {
      text = "00:${counter.toString().padLeft(2, '0')}";
    }
    setState(() {
      resendText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VerifyEmailCubit, BaseState>(
          bloc: _verifyCubit,
          listener: (context, state) async {
            if (state.main.isFailure) {
              showError(context, state.main.errorMessage ?? '');
            }
            if (state.main.isInProgress) {
              showLoadingBar(context, "Loading...");
            }
            if (state.main.isOtpSent) {
              showSuccess(context, "OTP sent successfully.");
            }
            if (state.main.isSuccess) {
              hideSnackBar(context);
              if (isFrom == ForgotPassword.routeName) {
                print(state.main.token);
                _navigationService.navigateWithBack(CreateNewPassword.routeName,
                    arguments: {"token": state.main.token});
              } else if (isFrom == "LoginScreen") {
                _loginCubit.loginWithEmailPasswordPressed(
                    password: password, email: userEmail);
              } else {
                showDialogFunction();
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppClr.black,
              body: Column(
                children: [
                  Column(children: [
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
                      style: AppTheme.white16w500,
                      otpFieldStyle: OtpFieldStyle(
                          backgroundColor: AppClr.otpBackground,
                          focusBorderColor: AppClr.blue),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 10,
                      onChanged: (pin) {
                        setState(() {
                          otp = pin;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextSpanBold(
                        title: 'Did’t receive any code?  ',
                        boldText: resendText,
                        onClick: () {
                          if (resendText == "Resend OTP" &&
                              !state.main.isInProgress) {
                            timerFunction();

                            _verifyCubit.sendEmailVerifyOTP(
                              email: userEmail,
                            );
                          }
                        }),
                  ]),
                  Expanded(
                    child: Container(),
                  ),
                  ButtonPrimary(
                    title: "Continue",
                    onClick: () => {hitApi(state)},
                    buttonColor:
                        isValid(state) ? AppClr.blue : AppClr.greyButton,
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            );
          }),
    );
  }
}
