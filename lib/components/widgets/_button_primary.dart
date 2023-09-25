import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final Function() onClick;
  final Color buttonColor;

  const ButtonPrimary(
      {super.key,
      required this.title,
      required this.onClick,
      this.buttonColor = AppClr.blue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // padding: EdgeInsets.all(16.0),
        height: 50,
        width: ClassMediaQuery.screenWidth - 20, // Padding around the text
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: buttonColor),
          onPressed: onClick,
          child: Center(
            child: Text(
              title,
              // textAlign: TextAlign.center,
              style: AppTheme.white16w500,
            ),
          ),
        ),
      ),
    );
  }
}
