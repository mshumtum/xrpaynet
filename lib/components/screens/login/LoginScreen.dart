import 'package:flutter/material.dart';

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
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
          onPressed: () => _navigationService.goBack(),
        ),
        title: const Text(""),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleText(),
          _headingText(),
          const SizedBox(height:30,),
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

  Widget _titleText() {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: const Align(
          alignment: Alignment.center,
          child: Text(
            'Create Account',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontFamily: 'Roboto-Medium'),
          )),
    );
  }

  Widget _headingText() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child:  Align(
          alignment: Alignment.center,
          child: Text(
            'Enter the required details below to \ncreate your account!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor("#B6B6B8"),
                fontSize: 14,
                fontFamily: 'Roboto-Regular',
            ),
          )),
    );
  }
  Widget _headingFieldText(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0,left: 20.0),
      child:  Text(
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
