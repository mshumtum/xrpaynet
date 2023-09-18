import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class HeadingText extends StatelessWidget {
  final String title;
  final Color color;
  final double textSize;
  const HeadingText(
      {super.key,
      required this.title,
      this.color = AppClr.grey,
      this.textSize = 14.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: AppClr.grey,
            fontSize: textSize,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
