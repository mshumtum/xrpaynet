import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/HexColor.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
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
    final NavigationService navigationService = locator<NavigationService>();

    return Center(
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 70,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white),
              onPressed: () => {navigationService.goBack()},
            ),
            title: const Text(""),
            centerTitle: true,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 40.0,
            ),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: AppTheme.fontMedium),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppClr.greyText,
                    fontSize: 14,
                    fontFamily: AppTheme.fontRegular,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
