import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/components/utilities/validators.dart';
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
import 'package:xr_paynet/theme/AppTheme.dart';
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
  String buttonTitle = "Login";
  final CardLoginCubit _loginCubit = locator<CardLoginCubit>();
  final _debouncer = Debouncer(milliseconds: 500);
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginAttempts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    try {
      _timer.cancel();
    } catch (err) {
      print("ERROR-$err");
    }
  }

  void checkLoginAttempts() async {
    if (_loginCubit.state.main.isTimerRunning) {
      timerFunction(_loginCubit.state, 1, 0);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? timeStamp = prefs.getInt(Constants.loginAttemptFailTime);
      print("timeStamp======$timeStamp");
      (timeStamp == null || timeStamp == 0)
          ? print("NOT EMPTY") //_loginCubit.clearState()
          : _loginCubit.updateTimer(timer: timeStamp);
    }
  }

  bool get isPopulated =>
      Validators.isValidEmail(emailAddress) &&
      Validators.isValidPassword(password) &&
      buttonTitle == "Login";

  void _userTryLogin() {
    _loginCubit.loginWithEmailPasswordPressed(
        email: emailAddress.trim(), password: password.trim());
  }

  bool isValid(LoginState state) {
    return isPopulated && !state.main.isInProgress;
  }

  void timerFunction(LoginState state, int type, int countNo) {
    print("TYPE====$type,-------${state.main.counter}");
    setState(() {
      buttonTitle = "";
    });
    var count = 0;
    if (type == 1) {
      int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      int targetTimestamp =
          state.main.timestampOnStart; // Replace with your target timestamp

      Duration difference = DateTime.fromMillisecondsSinceEpoch(targetTimestamp)
          .difference(DateTime.fromMillisecondsSinceEpoch(currentTimestamp));
      int differenceInSeconds = difference.inSeconds;

      print("Time difference in seconds: $differenceInSeconds seconds");

      count = differenceInSeconds;
      if (count <= 0) {
        setState(() {
          buttonTitle = "Login";
        });
        _loginCubit.stopTimer();
        _loginCubit.clearState();
        return;
      }
    } else {
      count = countNo;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      count--;
      print("counter=====$count");
      String minutes = (count ~/ 60).toString().padLeft(2, '0');
      String remainingSeconds = (count % 60).toString().padLeft(2, '0');
      // _loginCubit.updateTimer(timer: count);
      setState(() {
        buttonTitle = '${minutes}:${remainingSeconds}';
      });
      if (count == 0) {
        print('Cancel timer');
        timer.cancel();
        setState(() {
          buttonTitle = "Login";
        });
        _loginCubit.stopTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => hideSnackBar1(context, 1),
        child: Scaffold(backgroundColor: AppClr.black, body: _rootUI()));
  }

  Widget _rootUI() {
    return BlocConsumer<CardLoginCubit, LoginState>(
      bloc: _loginCubit,
      listener: (context, state) async {
        print("ATTEMPT====${state.main.attempt}");
        if (state.main.isAttemptFail && !state.main.isTimerRunning) {
          print("ATTEMPT CALLED====${state.main.isTimerRunning}");
          _loginCubit.startTimer();
          timerFunction(state, 2, state.main.counter);
        }
        if (state.main.checkAttemptFailTime) {
          timerFunction(state, 1, 0);
        }
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
                      _debouncer.run(() => setState(() {
                            emailAddress = value;
                          }));
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PasswordTextField(
                      inputLabel: 'Password',
                      hintText: '******',
                      onChangeText: (value) {
                        _debouncer.run(() => setState(() {
                              password = value;
                            }));
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  _forgotText(),
                ]),
              ),
              _bottomView(state)
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

  Widget _bottomView(state) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buttonTitle == "Login"
              ? ButtonPrimary(
                  title: buttonTitle,
                  onClick: () {
                    _debouncer.run(() => {
                          if (emailAddress == "")
                            {showError(context, Constants.enter_email_address)}
                          else if (!Validators.isValidEmail(emailAddress))
                            {showError(context, Constants.enter_valid_email)}
                          else if (password == "")
                            {showError(context, Constants.enter_password)}
                          else if (!Validators.isValidPassword(password))
                            {showError(context, Constants.enter_valid_password)}
                          else //if (buttonTitle == "Login")
                            {_userTryLogin()}
                        });
                  },
                  buttonColor: isValid(state) ? AppClr.blue : AppClr.greyButton,
                )
              : Container(
                  height: 50,
                  child: Text(buttonTitle, style: AppTheme.greyWhite22Medium)),
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
