import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  const ButtonPrimary({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
