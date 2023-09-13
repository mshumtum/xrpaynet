import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleText(),
            _headingText(),
            const SizedBox(
              height: 30,
            ),
            const HeadingText(
              title: 'Email',
              color: AppClr.grey,
              textSize: 14.0,
            ),
            const SizedBox(height: 15,),
            InputField(hintText: 'Enter Email',inputType: TextInputType.emailAddress),
            const SizedBox(height: 20,),
            const HeadingText(
              title: 'Create Password',
              color: AppClr.grey,
              textSize: 14.0,
            ),
            const SizedBox(height: 15,),
            PasswordTextField(
                hintText: 'Password',
              ),

            // _emailInputField(),
            const SizedBox(height: 20,),
            const HeadingText(
              title: 'Confirm Password',
              color: AppClr.grey,
              textSize: 14.0,
            ),
            const SizedBox(height: 15,),
            PasswordTextField(
              hintText: 'Confirm Password',
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                _checkbox()
              ],
            )
          ],
        ),
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
      child: Align(
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

  Widget _checkbox(){
    return Checkbox(
      value: this.value,
      onChanged: (bool? value){
        if(value != null){
          setState(() {
            this.value=value;
          });
        }

      },
    ); //Checkbox
  }
}
