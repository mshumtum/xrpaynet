import 'package:flutter/material.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

class Header extends StatelessWidget {
  final String title;
  final bool isHideBack;
  final String secondaryButtonImg;
  final String secondaryButtonText;
  final Function()? secondaryClick;

  const Header(
      {super.key,
      required this.title,
      this.isHideBack = true,
      this.secondaryButtonImg = "",
      this.secondaryButtonText = "",
      this.secondaryClick});

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = locator<NavigationService>();

    return Container(
      color: AppClr.grey2,
      child: AppBar(
          toolbarHeight: 60,
          leading: isHideBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.white),
                  onPressed: () => {navigationService.goBack()},
                )
              : null,
          title: Text(
            title,
            style: AppTheme.white18Medium,
          ),
          centerTitle: true,
          actions: <Widget>[
            secondaryButtonImg != ""
                ? GestureDetector(
                    onTap: secondaryClick,
                    child: Row(
                      children: [
                        Image.asset(
                          secondaryButtonImg,
                          width: 16,
                        ),
                        secondaryButtonText != ""
                            ? Row(children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  secondaryButtonText,
                                  style: AppTheme.white14Regular,
                                )
                              ])
                            : Container()
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(
              width: 15,
            )
          ]),
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
          const SizedBox(
            height: 5,
          ),
          AppBar(
            toolbarHeight: 50,
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
                      color: AppClr.grey2,
                      fontSize: 14,
                      fontFamily: AppTheme.fontRegular,
                      height: 1.5),
                )),
          )
        ],
      ),
    );
  }
}

class TopHeaderWithIcons extends StatefulWidget {
  final String leftIcon;
  final String title;
  final String rightIcon;
  final Function? onClickLeftIcon;
  final Function onClickRightIcon;

  const TopHeaderWithIcons(
      {super.key,
      this.leftIcon = "",
      required this.title,
      required this.rightIcon,
      this.onClickLeftIcon,
      required this.onClickRightIcon});

  @override
  State<TopHeaderWithIcons> createState() => _TopHeaderWithIconsState();
}

class _TopHeaderWithIconsState extends State<TopHeaderWithIcons> {
  @override
  Widget build(BuildContext context) {
    return _topBar();
  }

  Widget _topBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.leftIcon != ""
              ? InkWell(
                  onTap: () {
                    widget.onClickLeftIcon!();
                  },
                  child: Image.asset(
                    widget.leftIcon,
                    width: 20,
                    height: 20,
                  ),
                )
              : Container(),
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 18,
                color: AppClr.white,
                fontWeight: FontWeight.w500,
                fontFamily: AppTheme.fontMedium),
          ),
          InkWell(
            onTap: () {
              widget.onClickRightIcon();
            },
            child: Image.asset(
              widget.rightIcon,
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
