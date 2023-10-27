import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/LifeStylePlusCards.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/ApplyPhysicalCardForm.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LifeStylePlusKYC.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/_link_card.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_circle_container.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/theme/Images.dart';

class LifeStylePlusApplied extends StatefulWidget {
  static const String routeName = '/life_style_plus_applied';
  final Object? arguments;
  const LifeStylePlusApplied({super.key, this.arguments});

  @override
  State<LifeStylePlusApplied> createState() => _LifeStylePlusAppliedState();
}

class _LifeStylePlusAppliedState extends State<LifeStylePlusApplied> {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isPhysicalCardSelected = true;
  bool isKycRejected = false;
  String statusOfCards = "APPLIED";
  String buttonTitle = "Link Your Card";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var params = (widget?.arguments as Map);
    if (params?["isFrom"] == "linkCard") {
      setState(() {
        statusOfCards = "ISSUED";
        buttonTitle = "Activate Your Card";
      });
    } else if (params?["isFrom"] == "rejected") {
      setState(() {
        statusOfCards = "Rejected";
        buttonTitle = "Resubmit";
        isKycRejected = true;
      });
    } else if (params?["isFrom"] == "success") {
      setState(() {
        statusOfCards = "";
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
              title: 'LifeStyle Plus Cards',
              rightIcon: Images.ic_logout,
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
                          WelcomeScreen.routeName,
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 35),
            _cardSelection(),
            _cardImg(),
            _details(),
            isKycRejected
                ? _kyc_rejected()
                : Container(height: ClassMediaQuery.screenHeight / 6),
            statusOfCards != ""
                ? Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonPrimary(
                        title: buttonTitle,
                        onClick: () {
                          if (statusOfCards == "ISSUED" || isKycRejected) {
                            _navigationService.navigateWithBack(
                                LifeStylePlusKYC.routeName,
                                arguments: {"isKycRejected": isKycRejected});
                          } else {
                            _navigationService
                                .navigateWithBack(LinkCard.routeName);
                          }
                        },
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
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
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      width: ClassMediaQuery.screenWidth,
      height: 250,
      child: Stack(
        children: [
          Image.asset(isPhysicalCardSelected
              ? Images.lsPlusPhysicalDummy
              : Images.lsPlusVirtualDummy),
          Positioned(
            right: 20,
            top: 17,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(
                        0x47000000), // Color with alpha (transparency) value
                    offset: Offset(0, 3), // Horizontal and vertical offset
                    blurRadius: 6.0, // Spread of the shadow
                  ),
                ],
              ),
              child: statusOfCards != "Rejected"
                  ? Text(
                      statusOfCards,
                      style: TextStyle(
                        fontSize: 14, // Adjust the font size as needed
                        fontWeight:
                            FontWeight.bold, // Adjust the font weight as needed
                        color: statusOfCards == "ISSUED"
                            ? AppClr.blue
                            : AppClr.red, // Adjust the text color as needed
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }

  Widget _kyc_rejected() {
    return Column(
      children: [
        SizedBox(
          height: 35,
        ),
        Image.asset(
          Images.icKycRejected,
          width: 56,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "KYC is Rejected",
          style: AppTheme.white20Medium,
        ),
        SizedBox(
          height: 35,
        ),
      ],
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
                height: 15,
              )
            ],
          )),
    );
  }

  Widget _types(String type, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
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
}
