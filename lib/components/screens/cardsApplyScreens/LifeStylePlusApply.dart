import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/ApplyPhysicalCardForm.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/ApplyVirtualCardForm.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_circle_container.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Constants.dart';
import 'package:xr_paynet/theme/Images.dart';

class LifeStylePlusApply extends StatefulWidget {
  static const String routeName = '/life_style_plus_apply';
  const LifeStylePlusApply({super.key});

  @override
  State<LifeStylePlusApply> createState() => _LifeStylePlusApplyState();
}

class _LifeStylePlusApplyState extends State<LifeStylePlusApply> {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isPhysicalCardSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SingleChildScrollView(
            child: Column(
          children: [
            TopHeaderWithIcons(
              leftIcon: Images.ic_wallet,
              title: 'LifeStyle Plus Cards',
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
                            Navigator.of(context).pop();
                            _navigationService.navigateWithRemovingAllPrevious(
                                WelcomeScreen.routeName);
                          });
                    });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            _cardSelection(),
            _cardImg(),
            _details(),
            _certified(),
            const SizedBox(
              height: 25,
            ),
            ButtonPrimary(
                title: 'Apply Now',
                onClick: () {
                  _navigationService
                      .navigateWithBack(ApplyPhysicalCardForm.routeName);
                }),
            const SizedBox(
              height: 10,
            ),
          ],
        )));
  }

  Widget _cardSelection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isPhysicalCardSelected = true;
                });
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: isPhysicalCardSelected
                      ? AppClr.blue
                      : AppClr.inputFieldBg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Physical Card',
                    style: TextStyle(
                        color:
                            isPhysicalCardSelected ? Colors.white : AppClr.grey,
                        fontSize: 14,
                        fontFamily: AppTheme.fontMedium),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                setState(() {
                  isPhysicalCardSelected = false;
                });
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: !isPhysicalCardSelected
                      ? AppClr.blue
                      : AppClr.inputFieldBg,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Virtual Card',
                    style: TextStyle(
                        color: !isPhysicalCardSelected
                            ? Colors.white
                            : AppClr.grey,
                        fontSize: 14,
                        fontFamily: AppTheme.fontMedium),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardImg() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: ClassMediaQuery.screenWidth,
      height: 250,
      child: Image.asset(isPhysicalCardSelected
          ? Images.lsPlusPhysicalDummy
          : Images.lsPlusVirtualDummy),
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
              _types('Annual Maintenance Fee', '\$ 29'),
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
              _rules(Constants.lifePhysicalDiscount1),
              const SizedBox(
                height: 20,
              ),
              _rules(Constants.lifePhysicalDiscount2),
              const SizedBox(
                height: 20,
              ),
              _rules(Constants.lifePhysicalBenefits),
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
