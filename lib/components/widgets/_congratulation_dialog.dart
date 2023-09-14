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

  const CongratulationDialog({
    super.key,
    required this.title,
    required this.descriptions,
    required this.doneTxt,
    required this.onClick,
  });

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
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppClr.dialogBackground),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Lottie.asset(Images.congratulationLottie, width: 140),
              Text(
                title,
                style: AppTheme.white18Medium,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                descriptions,
                style: AppTheme.resendGreyText14,
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(35, 25, 35, 1),
                child: ButtonPrimary(onClick: onClick, title: doneTxt),
              )
            ],
          ),
        ),
      ],
    );
  }
}
