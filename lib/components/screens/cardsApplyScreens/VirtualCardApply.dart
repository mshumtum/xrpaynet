import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/ApplyVirtualCardForm.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_circle_container.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/constants/Constants.dart';

import '../../../core/Locator.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../theme/Images.dart';
import '../../widgets/_button_primary.dart';

class VirtualCardApply extends StatefulWidget {
  static const String routeName = '/virtual_card_apply';
  final Object? arguments;
  const VirtualCardApply({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  State<VirtualCardApply> createState() => _VirtualCardApplyState();
}

class _VirtualCardApplyState extends State<VirtualCardApply> {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isClubCard = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var params = (widget.arguments as Map);
    if (params["isFrom"] == "lifestyleVirtual") {
      setState(() {
        isClubCard = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopHeaderWithIcons(
              leftIcon: Images.ic_wallet,
              title: isClubCard ? 'Club Card' : "LifeStyle Card",
              rightIcon: Images.ic_logout,
              onClickLeftIcon: () {
                _navigationService.goBack();
              },
              onClickRightIcon: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                          descriptions: "Are you sure you want to logout?",
                          doneTxt: "Done",
                          lottieFile: Images.logoutFileLottie,
                          onClick: () {
                            clearXrPayData(context);
                            Navigator.of(context).pop();
                            _navigationService.navigateWithRemovingAllPrevious(
                                WelcomeScreen.routeName);
                          });
                    });
              },
            ),
            _cardImg(),
            _details(),
            const SizedBox(
              height: 25,
            ),
            _certified(),
            const SizedBox(
              height: 25,
            ),
            ButtonPrimary(
                title: 'Apply Now',
                onClick: () {
                  _navigationService.navigateWithBack(
                      ApplyVirtualCardForm.routeName,
                      arguments: {
                        "isFrom":
                            isClubCard ? "clubVirtual" : "lifestyleVirtual"
                      });
                },
                horizontal: 15),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardImg() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: ClassMediaQuery.screenWidth,
      height: 250,
      child: Image.asset(
          isClubCard ? Images.xr_pay_net_card : Images.ic_virtual_ls_card),
    );
  }

  Widget _details() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppClr.inputFieldBg,
          ),
          child: Column(
            children: [
              _types('Card Currency', 'USD'),
              _types('Issuance Fee', '\$ 100'),
              _types('Payment Method', 'Crypto'),
              _types('Deposit Fee', '2%'),
              isClubCard
                  ? Container()
                  : _types('Annual Maintenance Fee', '\$ 29'),
              const SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }

  Widget _types(String type, String value) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: const TextStyle(
                color: AppClr.grey,
                fontSize: 14,
                fontFamily: AppTheme.fontRegular),
          ),
          Text(value,
              style: const TextStyle(
                  color: AppClr.white,
                  fontSize: 14,
                  fontFamily: AppTheme.fontMedium,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _certified() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // height: 180,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppClr.blue_gradient, AppClr.black_gradient],
            // Replace with your desired colors
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            transform: GradientRotation(182), // Convert degrees to radians
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _applePayAndGooglePay(),
              const SizedBox(
                height: 20,
              ),
              _rules(isClubCard
                  ? Constants.clubAnnualFee
                  : Constants.lifestyleAnnualFee),
              const SizedBox(
                height: 20,
              ),
              _rules(isClubCard
                  ? Constants.clubActivationFee
                  : Constants.lifeActivationFee),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }

  Widget _applePayAndGooglePay() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          child: const CircleContainer(
            containerSize: 6.0,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          width: ClassMediaQuery.screenWidth - 70, // Set the maximum width
          child: Wrap(
            spacing: 2.0,
            runSpacing: 5.0, // Adjust the spacing between rows
            children: <Widget>[
              _payeeData(Images.apple_pay_img, ",", 38.0),
              _payeeData(Images.gPay_img, ",", 38.0),
              _payeeData(Images.ic_samsung_pay, ",", 96.0),
              _payeeData(Images.ic_alipay, " & ", 56.0),
              _payeeData(Images.ic_we_share_pay, " Certified ", 96.0),

              // Add more Google Pay images as needed
            ],
          ),
        ),
      ],
    );
  }

  Widget _payeeData(image, text, width) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(
          image,
          width: width,
          // height: 16,
        ),
        _text1(text),
        SizedBox(
          width: 5,
        )
      ],
    );
  }

  Widget _rules(value) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: const CircleContainer(
              containerSize: 6.0,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          _text(value),
        ],
      ),
    );
  }

  Widget _text(value) {
    return Expanded(
      flex: 1,
      child: Text(
        value,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: AppClr.white,
            fontSize: 13,
            fontFamily: AppTheme.fontRegular),
      ),
    );
  }

  Widget _text1(value) {
    return Column(
      children: [
        const SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: AppClr.white,
              fontSize: 13,
              fontFamily: AppTheme.fontRegular),
        ),
      ],
    );
  }
}
