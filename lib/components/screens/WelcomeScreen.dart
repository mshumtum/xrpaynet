import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xr_paynet/components/widgets/ButtonPrimary.dart';
import 'package:xr_paynet/components/widgets/Header.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Constants.dart';
import 'package:xr_paynet/theme/Images.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      top: -70,
                      child: Image.asset(Images.ic_volta),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
                      child: Image.asset(
                        Images.ic_welcome_bg,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Image.asset(Images.ic_welcome_cards),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  Constants.welcomeText,
                  style: AppTheme.white40,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                const ButtonPrimary(title: "Create Your Account")
              ],
            ),
          ),
        ));
    // Container(
    //     padding: EdgeInsets.fromLTRB(35.0, 25.0, 35.0, 30.0),
    //     child: Column(children: [Header()])));
  }
}
