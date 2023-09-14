import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final Function() onClick;

  const ButtonPrimary({super.key, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: onClick,
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: 50,
            width: ClassMediaQuery.screenWidth - 20, // Padding around the text
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
              color: AppClr.blue,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTheme.body1,
            ),
          )),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  final String title;
  final Function() onClick;

  const ButtonSecondary(
      {super.key, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        height: 50,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: AppBar(
            backgroundColor: AppClr.greyButton,
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
