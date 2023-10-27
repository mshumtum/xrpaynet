import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/Debouncer.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/utilities/validators.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_password_text_filed.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/base_cubit/base_state.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/create_forgot_password.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class CreateNewPassword extends StatefulWidget {
  static const String routeName = '/create_new_password';
  final Object? arguments;

  const CreateNewPassword({
    super.key,
    this.arguments,
  });

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final NavigationService _navigationService = locator<NavigationService>();
  final _debouncer = Debouncer(milliseconds: 500);
  final CreateForgotPassCubit _forgotPassCubit =
      locator<CreateForgotPassCubit>();

  String token = "", password = "", confirmPassword = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var params = (widget.arguments as Map);
    token = params["token"];
    print("token====$token");
  }

  bool isValid(BaseState state) {
    print(
        "PASSWORD-----${password}-------${Validators.isValidPassword(password)}");
    return Validators.isValidPassword(password) &&
        password == confirmPassword &&
        !state.main.isInProgress;
  }

  void hitAPI() {
    _forgotPassCubit.createNewPassword(password: password, token: token);
  }

  void showDialogFunction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CongratulationDialog(
            title: "Successfully Changed",
            descriptions: "Congratulations your password has been reset",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CreateForgotPassCubit, BaseState>(
            bloc: _forgotPassCubit,
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

                showSuccess(
                    context, "Congratulations your password has been reset.");
                showDialogFunction();
              }
            },
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: AppClr.black,
                  body: SingleChildScrollView(
                      child: Column(children: [
                    SizedBox(
                        height: ClassMediaQuery.screenHeight / 1.1,
                        child: Column(children: [
                          const OnBoardingHeader(
                            title: 'Create New Password',
                            subTitle:
                                'Set the new password for your account so you\n can login and access all the features',
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          PasswordTextField(
                            inputLabel: 'Enter New Password',
                            hintText: '******',
                            onChangeText: (value) {
                              _debouncer.run(() => {
                                    setState(() {
                                      password = value;
                                    })
                                  });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          PasswordTextField(
                            inputLabel: 'Confirm Password',
                            hintText: '******',
                            onChangeText: (value) {
                              _debouncer.run(() => {
                                    setState(() {
                                      confirmPassword = value;
                                    })
                                  });
                            },
                          ),
                        ])),
                    _bottomView(state)
                  ])));
            }));
  }

  Widget _bottomView(state) {
    return SizedBox(
      // height: ClassMediaQuery.pendingContainerHeight(1.25),
      child: ButtonPrimary(
          title: 'Submit',
          onClick: () {
            if (isValid(state)) {
              hitAPI();
            }
          },
          buttonColor: isValid(state) ? AppClr.blue : AppClr.greyButton),
    );
  }
}
