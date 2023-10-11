import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/components/widgets/text_span_bold.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';

import '../../../theme/AppTheme.dart';
import '../../../theme/Colors.dart';
import '../../widgets/_button_primary.dart';
import '../../widgets/_password_text_filed.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = '/create_account';

  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final NavigationService _navigationService = locator<NavigationService>();
  bool value = false;

  // for get text field value use this
  // String text = InputField.getText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OnBoardingHeader(
              title: 'Create Account',
              subTitle:
                  'Enter the required details below to \ncreate your account!',
            ),
            const SizedBox(
              height: 46,
            ),
             InputField(
                inputLabel: "Email",
                hintText: 'Enter Email',
                inputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            PasswordTextField(
              inputLabel: 'Create Password',
              hintText: 'Password',
            ),
            const SizedBox(
              height: 15,
            ),
            PasswordTextField(
              inputLabel: 'Confirm Password',
              hintText: 'Confirm Password',
            ),
            const SizedBox(
              height: 15,
            ),
            _agreement(),
            _bottomView()
          ],
        ),
      ),
    );
  }

  Widget _checkbox() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: Checkbox(
        side: const BorderSide(color: AppClr.grey, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        checkColor: Colors.white,
        activeColor: Colors.blue,
        value: value,
        onChanged: (bool? value) {
          if (value != null) {
            setState(() {
              this.value = value;
            });
          }
        },
      ),
    ); //Checkbox
  }

  Widget _agreement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _checkbox(),
        Expanded(
            child: Column(
          children: [_text()],
        )),
      ],
    );
  }

  Widget _text() {
    return Container(
      width: ClassMediaQuery.screenWidth,
      margin: const EdgeInsets.only(top: 5.0, right: 20.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: const TextSpan(
          style: TextStyle(
            color: AppClr.grey2,
            fontSize: 14.0,
            fontFamily: AppTheme.fontLight,
          ),
          children: <TextSpan>[
            TextSpan(
                text:
                    'I certify that I am 18 years of age or older, and I agree to the '),
            TextSpan(
              text: 'User Agreement',
              style: TextStyle(
                  color: AppClr.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300),
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: AppClr.white,
                fontSize: 14.0,
              ),
            ),
            TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }

  Widget _bottomView() {
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonPrimary(
              title: 'Create Account',
              onClick: () {
                _navigationService.navigateWithBack(VerifyEmailByOTP.routeName,
                    arguments: {"isFrom": "createAccount"});
              }),
          const SizedBox(
            height: 15,
          ),
          TextSpanBold(
              title: 'Already have an account?  ',
              boldText: 'Login',
              onClick: () {
                _navigationService.navigateWithNoBack(LoginScreen.routeName);
              }),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
