import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final Function() onClick;

   const ButtonPrimary({super.key, required this.title, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        height: 60,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: AppBar(
            backgroundColor: AppClr.white,
            centerTitle: true,
            title: Text(
              title,
              style: AppTheme.body1,
            ),
          ),
        ),
      ),
    );
  }
}
