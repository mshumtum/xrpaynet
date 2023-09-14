import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateAccount.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/ForgotPassword.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';

import '../../../theme/Colors.dart';
import '../../utilities/HexColor.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
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
                const InputField(
                    inputLabel: "Email",
                    hintText: 'Enter Email',
                    inputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                PasswordTextField(
                  inputLabel: 'Password',
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                _forgotText(),
              ]),
            ),
            _bottomView()
          ],
        ),
      ),
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
            fontSize: 16,
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
                _navigationService
                    .navigateWithRemovingAllPrevious(HomePage.routeName);
              }),
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
