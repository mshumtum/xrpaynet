import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final Function() onClick;
  final Color buttonColor;
  final double horizontal;
  final bool isShimmer;

  const ButtonPrimary(
      {super.key,
      required this.title,
      required this.onClick,
      this.buttonColor = AppClr.blue,
      this.horizontal = 17,
      this.isShimmer = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: horizontal),
      width: ClassMediaQuery.screenWidth, // Padding around the text
      child: isShimmer
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade900,
              highlightColor: Colors.grey.shade800,
              child: Container(
                height: 310,
                width: ClassMediaQuery.screenWidth / 2.3,
                color: AppClr.black,
              ),
            )
          : ElevatedButton(
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
