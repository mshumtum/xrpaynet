import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/HexColor.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(40.0),
          bottomLeft: Radius.circular(40.0),
        ),
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

class OnBoardingHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  const OnBoardingHeader(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          toolbarHeight: 70,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.white),
            onPressed: () => {},
          ),
          title: const Text(""),
          centerTitle: true,
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: AppTheme.fontFamily),
            )),
        const SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#B6B6B8"),
                fontSize: 14,
                fontFamily: AppTheme.fontRegular,
              ),
            ))
      ],
    );
  }
}
