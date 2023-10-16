import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/VerifyEmail.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/components/widgets/text_span_bold.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/register_cubit/register_cubit.dart';
import 'package:xr_paynet/theme/Constants.dart';

import '../../../constants/constants.dart';
import '../../../theme/AppTheme.dart';
import '../../../theme/Colors.dart';
import '../../utilities/utility.dart';
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
  final RegisterCubit _registerCubit = sl<RegisterCubit>();
  bool value = false;

  String emailAddress = "";
  String password = "";
  String confirmPassword = "";

  // for get text field value use this
  // String text = InputField.getText();
  void _userRegister() {
    _registerCubit.registerSubmitted(userData: '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: _rootUI(),
    );
  }

  Widget _rootUI() {
    return BlocConsumer<RegisterCubit, RegisterState>(
      bloc: _registerCubit,
      listener: (context, state) async {
        if (state.main.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Expanded(
                        child: Text(state.main.errorMessage ??
                            state.main.message ??
                            '')),
                    const Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
        }

        if (state.main.isInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.main.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logged in successfully'),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
          _navigationService.navigateWithBack(VerifyEmailByOTP.routeName,
              arguments: {"isFrom": "createAccount"});
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
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
                inputType: TextInputType.emailAddress,
                onChangeText: (value) {
                  emailAddress = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PasswordTextField(
                inputLabel: 'Create Password',
                hintText: '*********',
                onChangeText: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PasswordTextField(
                inputLabel: 'Confirm Password',
                hintText: '*********',
                onChangeText: (value) {
                  confirmPassword = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _agreement(),
              _bottomView()
            ],
          ),
        );
      },
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
              title: Constants.create_account,
              onClick: () {
                if (emailAddress == "") {
                  showToast(context, Constants.enter_email_address);
                } else if (!isEmailValid(emailAddress)) {
                  showToast(context, Constants.enter_valid_email);
                } else if (password == "") {
                  showToast(context, Constants.enter_password);
                } else if (!isPasswordValid(password)) {
                  showToast(context,
                      Constants.enter_valid_password);
                }else if(confirmPassword == ""){
                  showToast(context, Constants.enter_confirm_password);
                }else if(confirmPassword != password){
                  showToast(context, Constants.enter_confirm_password_valid);
                }else{
                  _userRegister();
                }
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
