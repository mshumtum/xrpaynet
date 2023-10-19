import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateAccount.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/ForgotPassword.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/Debouncer.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/card_login_cubit/card_login_cubit.dart';
import 'package:xr_paynet/constants/Constants.dart';
import '../../../constants/FormSubmissionStatus.dart';
import '../../../theme/Colors.dart';
import '../../widgets/_button_primary.dart';
import '../../widgets/_input_filed.dart';
import '../../widgets/_password_text_filed.dart';
import '../../widgets/text_span_bold.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_page';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final NavigationService _navigationService = locator<NavigationService>();
  String emailAddress = "";
  String password = "";
  final CardLoginCubit _loginCubit = locator<CardLoginCubit>();
  final _debouncer = Debouncer(milliseconds: 500);

  void _userTryLogin() {
    _loginCubit.loginWithEmailPasswordPressed(
        email: emailAddress.trim(), password: password.trim());
  }

  bool isValid() {
    return isEmailValid(emailAddress) && isPasswordValid(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppClr.black, body: _rootUI());
  }

  Widget _rootUI() {
    return BlocConsumer<CardLoginCubit, LoginState>(
      bloc: _loginCubit,
      listener: (context, state) async {
        if (state.main.isFailure) {
          showError(
              context, state.main.errorMessage ?? state.main.message ?? '');
        }
        if (state.main.isVerificationPending) {
          hideSnackBar(context);
          _navigationService.navigateWithBack(VerifyEmailByOTP.routeName,
              arguments: {
                "isFrom": "LoginScreen",
                'email': emailAddress,
                "password": password
              });
        }

        if (state.main.isInProgress) {
          showLoadingBar(context, "Loading...");
        }
        if (state.main.isSuccess) {
          showSuccess(context, state.main.message ?? "Logged In");
          _navigationService
              .navigateWithRemovingAllPrevious(HomePage.routeName);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ClassMediaQuery.screenHeight / 1.2,
                child: Column(children: [
                  const OnBoardingHeader(
                    title: 'Login To Your Account',
                    subTitle:
                        'Enter required details below to access\n your account!',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputField(
                    inputLabel: "Email",
                    hintText: 'Enter Email',
                    inputType: TextInputType.emailAddress,
                    onChangeText: (value) {
                      _debouncer.run(() => {
                            setState(() {
                              emailAddress = value;
                            })
                          });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PasswordTextField(
                      inputLabel: 'Password',
                      hintText: '******',
                      onChangeText: (value) {
                        _debouncer.run(() => {
                              setState(() {
                                password = value;
                              })
                            });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  _forgotText(),
                ]),
              ),
              _bottomView()
            ],
          ),
        );
      },
    );
  }

  Widget _forgotText() {
    return Container(
      width: ClassMediaQuery.screenWidth,
      padding: EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          _navigationService.navigateWithBack(ForgotPassword.routeName);
        },
        child: const Text(
          'Forgot Password? ',
          style: TextStyle(
            fontSize: 14,
            color: AppClr.grey,
          ),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget _bottomView() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonPrimary(
            title: 'Login',
            onClick: () {
              // _navigationService
              //     .navigateWithRemovingAllPrevious(HomePage.routeName);
              if (emailAddress == "") {
                showError(context, Constants.enter_email_address);
              } else if (!isEmailValid(emailAddress)) {
                showError(context, Constants.enter_valid_email);
              } else if (password == "") {
                showError(context, Constants.enter_password);
              } else if (!isPasswordValid(password)) {
                showError(context, Constants.enter_valid_password);
              } else {
                _userTryLogin();
              }
            },
            buttonColor: isValid() ? AppClr.blue : AppClr.greyButton,
          ),
          const SizedBox(
            height: 15,
          ),
          TextSpanBold(
              title: "Don't have an account? ",
              boldText: 'Sign Up',
              onClick: () {
                _navigationService.navigateWithNoBack(CreateAccount.routeName);
              }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
