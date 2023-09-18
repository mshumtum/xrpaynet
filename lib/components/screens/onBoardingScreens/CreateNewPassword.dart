import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_password_text_filed.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/Colors.dart';

class CreateNewPassword extends StatefulWidget {
  static const String routeName = '/create_new_password';

  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
              height: ClassMediaQuery.screenHeight / 1.25,
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
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                PasswordTextField(
                  inputLabel: 'Confirm Password',
                  hintText: 'Confirm Password',
                ),
              ])),
          _bottomView()
        ])));
  }

  Widget _bottomView() {
    return SizedBox(
      height: ClassMediaQuery.pendingContainerHeight(1.25),
      child: ButtonPrimary(
          title: 'Submit',
          onClick: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CongratulationDialog(
                      title: "Successfully Changed",
                      descriptions:
                          "Congratulations your password has been reset",
                      doneTxt: "Done",
                      onClick: () {
                        Navigator.of(context).pop();
                        _navigationService.navigateWithRemovingAllPrevious(
                            HomePage.routeName);
                      });
                });
          }),
    );
  }
}
