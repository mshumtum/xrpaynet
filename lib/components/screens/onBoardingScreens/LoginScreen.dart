import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_header.dart';

import '../../../theme/Colors.dart';
import '../../core/Locator.dart';
import '../../core/navigation/navigation_service.dart';
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
  static double mainHeight = ClassMediaQuery.screenHeight / 1.2;
  double pendingHeight = ClassMediaQuery.screenHeight - mainHeight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ClassMediaQuery.screenHeight/2,
            child: Column(
              children: [
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
              ],
            ),
          ),
          _bottomView()


        ],
      ),
    );
  }

  Widget _forgotText() {
    return  Positioned(
      top: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.only(right: 22),
        width: ClassMediaQuery.screenWidth,
        child: const Text(
          'Forgot Password? ',
          style: TextStyle(fontSize: 16, color: AppClr.grey,),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget _bottomView() {
    return SizedBox(
      height: pendingHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonPrimary(title: 'Login', onClick: () {}),
          const SizedBox(
            height: 15,
          ),
          TextSpanBold(
              title: "Don't have an account? ",
              boldText: 'Sing Up',
              onClick: () {
                _navigationService.navigateWithBack(LoginScreen.routeName);
              })
        ],
      ),
    );
  }

}
