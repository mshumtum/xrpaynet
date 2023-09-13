import 'package:flutter/material.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';

import '../../../theme/Colors.dart';
import '../../core/Locator.dart';
import '../../core/navigation/navigation_service.dart';
import '../../utilities/HexColor.dart';
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
            const InputField(
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
            Row(
              children: [_checkbox()],
            )
          ],
        ),
      ),
    );
  }

  Widget _checkbox() {
    return Checkbox(
      value: this.value,
      onChanged: (bool? value) {
        if (value != null) {
          setState(() {
            this.value = value;
          });
        }
      },
    ); //Checkbox
  }
}
