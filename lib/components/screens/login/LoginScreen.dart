import 'package:flutter/material.dart';
import 'package:xr_paynet/components/widgets/Header.dart';

import '../../../theme/Colors.dart';
import '../../core/Locator.dart';
import '../../core/navigation/navigation_service.dart';
import '../../utilities/HexColor.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnBoardingHeader(
            title: 'Create Account',
            subTitle:
                'Enter the required details below to \ncreate your account!',
          ),
          const SizedBox(
            height: 30,
          ),
          _headingFieldText('Email'),
          _emailInputField(),
          _headingFieldText('Create Password'),
          _emailInputField(),
          _headingFieldText('Confirm Password'),
          _emailInputField(),
        ],
      ),
    );
  }

  Widget _headingFieldText(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: HexColor("#B6B6B8"),
          fontSize: 14,
          fontFamily: 'Roboto-Regular',
        ),
      ),
    );
  }

  Widget _emailInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Username',
          filled: true,
          fillColor: const Color.fromRGBO(255, 0, 0, 1),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
