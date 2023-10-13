import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final Function() onClick;
  final Color buttonColor;
  final double horizontal;

  const ButtonPrimary(
      {super.key,
      required this.title,
      required this.onClick,
      this.buttonColor = AppClr.blue,
      this.horizontal = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: horizontal),
      width: ClassMediaQuery.screenWidth, // Padding around the text
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          splashFactory: NoSplash.splashFactory,
          backgroundColor: buttonColor,
        ),
        onPressed: onClick,
        child: Center(
          child: Text(
            title,
            // textAlign: TextAlign.center,
            style: AppTheme.white16w500,
          ),
        ),
      ),
    );
  }
}
