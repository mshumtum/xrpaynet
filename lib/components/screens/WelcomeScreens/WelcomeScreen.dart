import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/CreateAccount.dart';
import 'package:xr_paynet/components/screens/onBoardingScreens/LoginScreen.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/core/network/AsymmetricCrypt.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Constants.dart';
import 'package:xr_paynet/theme/Images.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome_page';
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final NavigationService _navigationService = locator<NavigationService>();
  dynamic _funtions;

  @override
  void initState() {
    super.initState();

    // _funtions = FirebaseFunctions.instance;
    // getData();
  }

  Future<void> getData() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "sholu@yopmail.com", password: "Test@123");

      getUserToken(credential.user!.uid);
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    print("getUserDetails====");
    HttpsCallable callable = _funtions.httpsCallable('getUserDetails');
    final results = await callable.call();
    print(results.data);
  }

  Future<String?> getUserToken(String uid) async {
    try {
      final user = await FirebaseAuth.instance.authStateChanges().first;
      if (user != null) {
        final token = await FirebaseMessaging.instance.getToken();
        return token;
      }
      return null;
    } catch (e) {
      print("Error getting user token: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                            child: Image.asset(Images.icVolta, width: 112))),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                    child: Image.asset(
                      Images.ic_welcome_bg,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    left: 20,
                    child: Image.asset(
                      Images.ic_welcome_cards,
                      // width: ClassMediaQuery.screenWidth - 1,
                      // height: 130,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                Constants.welcomeText,
                style: AppTheme.white40,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 36,
              ),
              ButtonPrimary(
                title: "Create Account",
                onClick: () {
                  _navigationService.navigateWithBack(CreateAccount.routeName);
                },
              ),
              const SizedBox(height: 14),
              ButtonPrimary(
                title: "Login",
                onClick: () {
                  // _navigationService.navigateWithBack(LoginScreen.routeName);
                  // var TEST = AsymmetricCrypt().encrypt(
                  //    );
                  // print(TEST);
                  AsymmetricCrypt().encryptData(
                      {"email": "munish@gmail.com", "password": "Test@132"});
                },
                buttonColor: AppClr.greyButton,
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ));
    // Container(
    //     padding: EdgeInsets.fromLTRB(35.0, 25.0, 35.0, 30.0),
    //     child: Column(children: [Header()])));
  }
}
