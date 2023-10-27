import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/card_recharge/CardRecharge.dart';
import 'package:xr_paynet/components/screens/transaction_history/TransactionHistory.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../../core/Locator.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../theme/Images.dart';
import '../../utilities/ClassMediaQuery.dart';
import '../../widgets/_trans_history.dart';

class LifeStylePlusCards extends StatefulWidget {
  static const String routeName = '/lifestyle_plus_screens';
  const LifeStylePlusCards({Key? key}) : super(key: key);

  @override
  State<LifeStylePlusCards> createState() => _LifeStylePlusCardsState();
}

class _LifeStylePlusCardsState extends State<LifeStylePlusCards> {
  bool isPhysicalCardSelected = true;
  bool isFrontSideVisible = true;
  late FlipCardController _controller;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = FlipCardController();
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
            const SizedBox(
              height: 30,
            ),
            _cardSelection(),
            FlipCard(
                controller: _controller,
                fill: Fill.fillBack,
                direction: FlipDirection.HORIZONTAL, // default
                side: CardSide.FRONT,
                front: _frontCardImage(),
                back: _backCardImage(),
                flipOnTouch: false),
            const SizedBox(
              height: 10,
            ),
            ButtonPrimary(
              title: 'Recharge',
              onClick: () {
                _navigationService.navigateWithBack(CardRecharge.routeName);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            isFrontSideVisible ? _cardBalance() : const Text(''),
            const SizedBox(
              height: 15,
            ),
            _headingText(),
            const TransHistory(
              itemCount: 4,
            ),
            const SizedBox(
              height: 15,
            ),
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
                  if (!_controller.state!.isFront) {
                    _controller.toggleCard();
                  }
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
                if (!_controller.state!.isFront) {
                  _controller.toggleCard();
                }
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

  Widget _frontCardImage() {
    return Container(
      height: 250,
      width: ClassMediaQuery.screenWidth,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            child: Image.asset(isPhysicalCardSelected
                ? Images.card_front_img
                : Images.ic_lsp_visa_card),
          ),
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(top: 12, right: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  _controller.toggleCard();
                },
                child: Text(
                  'VIEW DETAILS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppTheme.fontBold),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40, right: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                'ACTIVATED',
                style: TextStyle(
                    color: AppClr.green,
                    fontFamily: AppTheme.fontBold,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backCardImage() {
    return Container(
      height: 250,
      width: ClassMediaQuery.screenWidth,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Stack(
        children: [
          Image.asset(Images.card_back_img,
              height: 250, width: ClassMediaQuery.screenWidth),
          Positioned(
            right: 0,
            bottom: 80,
            child: InkWell(
              onTap: () {
                _controller.toggleCard();
              },
              child: Text(
                'BACK TO MAIN',
                style: AppTheme.white11Bold,
              ),
            ),
          ),
          Positioned(
              top: ClassMediaQuery.screenHeight > 700 ? 117 : 113,
              child: Row(
                children: [
                  SizedBox(width: ClassMediaQuery.screenWidth / 2.8),
                  Text(
                    "CVV 123",
                    style: AppTheme.black12Bold,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text("Prepaid", style: AppTheme.black12Bold)
                ],
              )),
          Positioned(
            top: 145,
            left: ClassMediaQuery.screenWidth / 10,
            child: Text(
              "0012 3345 6788 0010",
              style: AppTheme.black16Regular,
            ),
          ),
          Positioned(
              top: 165,
              child: Row(
                children: [
                  SizedBox(width: ClassMediaQuery.screenWidth / 2.1),
                  const Text(
                    "VALID\nTHRU",
                    style: AppTheme.black10Regular,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("11/23", style: AppTheme.black12Bold)
                ],
              )),
          Positioned(
            bottom: 30,
            // bottom: ClassMediaQuery.screenHeight > 700 ? 35 : 25,
            left: ClassMediaQuery.screenWidth / 3.5,
            width: ClassMediaQuery.screenWidth / 1.8,
            child: Text(
              "Important: This card is issued by Paytend Europe UAB pursuant to license by VISA.",
              style: AppTheme.black10Regular,
            ),
          )
        ],
      ),
    );
  }

  Widget _cardBalance() {
    return Container(
      width: ClassMediaQuery.screenWidth,
      margin: const EdgeInsets.only(top: 5.0, right: 20.0),
      child: RichText(
        textAlign: TextAlign.end,
        text: const TextSpan(
          style: TextStyle(
            color: AppClr.grey2,
            fontSize: 14.0,
            fontFamily: AppTheme.fontLight,
          ),
          children: <TextSpan>[
            TextSpan(text: 'Card Balance: '),
            TextSpan(
              text: '\$ 200',
              style: TextStyle(
                  color: AppClr.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headingText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: ClassMediaQuery.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Transaction History',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: AppTheme.fontMedium,
                fontSize: 14,
                color: AppClr.white),
          ),
          InkWell(
              onTap: () {
                _navigationService
                    .navigateWithBack(TransactionHistory.routeName);
              },
              child: Text('View All',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: AppTheme.fontMedium,
                      fontSize: 14,
                      color: AppClr.white))),
        ],
      ),
    );
  }
}
