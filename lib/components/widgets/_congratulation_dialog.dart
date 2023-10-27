import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:lottie/lottie.dart';
import 'package:xr_paynet/theme/Images.dart';

class CongratulationDialog extends StatelessWidget {
  final String title, descriptions, doneTxt;
  final Function() onClick;
  final String lottieFile;
  final double horizontalMargin;

  const CongratulationDialog(
      {super.key,
      required this.title,
      required this.descriptions,
      required this.doneTxt,
      required this.onClick,
      required this.lottieFile,
      this.horizontalMargin = 0});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: SizedBox(
        width: ClassMediaQuery.screenWidth,
        height: ClassMediaQuery.screenHeight,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ),
      ),
    );
  }

  contentBox(context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppClr.dialogBackground),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Lottie.asset(this.lottieFile, width: 140),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppClr.white,
                        height: 2.4),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Text(
                      descriptions,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppClr.resendGreyText,
                          height: 1.6),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  ButtonPrimary(
                      onClick: onClick,
                      title: doneTxt,
                      horizontal: horizontalMargin)
                ],
              ),
            ),
          ],
        ));
  }
}

class ConfirmationDialog extends StatelessWidget {
  final String title, descriptions, doneTxt;
  final Function() onClick;
  final String lottieFile;

  const ConfirmationDialog(
      {super.key,
      this.title = "",
      required this.descriptions,
      required this.doneTxt,
      required this.onClick,
      required this.lottieFile});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: SizedBox(
        width: ClassMediaQuery.screenWidth,
        height: ClassMediaQuery.screenHeight,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ),
      ),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppClr.dialogBackground),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Lottie.asset(this.lottieFile, width: 140),
              title != ""
                  ? Text(
                      title,
                      style: AppTheme.white18Medium,
                    )
                  : Container(),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  descriptions,
                  style: AppTheme.resendGreyText14,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: ClassMediaQuery.screenWidth / 2.9,
                      height: 44,
                      child: ButtonPrimary(
                          onClick: () {
                            Navigator.of(context).pop();
                          },
                          title: "No",
                          buttonColor: AppClr.greyQrBack,
                          horizontal: 1),
                    ),
                    Container(
                      width: ClassMediaQuery.screenWidth / 2.9,
                      height: 44,
                      child: ButtonPrimary(
                          onClick: onClick, title: "Yes", horizontal: 1),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
