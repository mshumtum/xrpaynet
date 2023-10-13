import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/card_recharge/CardRecharge.dart';
import 'package:xr_paynet/components/screens/transaction_history/TransactionHistory.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_trans_history.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class ActiveVirtualCards extends StatefulWidget {
  static const String routeName = '/active_virtual_cards';
  final Object? arguments;
  const ActiveVirtualCards({super.key, this.arguments});

  @override
  State<ActiveVirtualCards> createState() => _ActiveVirtualCardsState();
}

class _ActiveVirtualCardsState extends State<ActiveVirtualCards> {
  bool isClubCard = true;
  bool isFrontSideVisible = true;
  late FlipCardController _controller;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = FlipCardController();

    var params = (widget?.arguments as Map);
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
              title: isClubCard ? 'Club Card' : 'LifeStyle Card',
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

  Widget _frontCardImage() {
    return Container(
      height: 250,
      width: ClassMediaQuery.screenWidth,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            child: Image.asset(isClubCard
                ? Images.active_club_front
                : Images.ic_active_ls_front),
          ),
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(top: 38, right: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  _controller.toggleCard();
                },
                child: Text(
                  'VIEW DETAILS',
                  style: TextStyle(
                      color: isClubCard ? Colors.white : AppClr.blue,
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
          SizedBox(
            height: 250,
            child: Image.asset(isClubCard
                ? Images.active_club_back
                : Images.ic_active_ls_back),
          ),
          Positioned(
            right: 0,
            bottom: 78,
            child: InkWell(
              onTap: () {
                _controller.toggleCard();
              },
              child: Text(
                'BACK TO MAIN',
                style: isClubCard ? AppTheme.white11Bold : AppTheme.blue11Bold,
              ),
            ),
          ),
          Positioned(
              top: 113,
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
                  Text("Prepaid", style: AppTheme.white12Bold)
                ],
              )),
          Positioned(
            top: 145,
            left: ClassMediaQuery.screenWidth / 10,
            child: Text(
              "0012 3345 6788 0010",
              style: AppTheme.white16Regular,
            ),
          ),
          Positioned(
              top: 165,
              child: Row(
                children: [
                  SizedBox(width: ClassMediaQuery.screenWidth / 2.1),
                  Text(
                    "VALID\nTHRU",
                    style: AppTheme.white10Regular,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("11/23", style: AppTheme.white12Bold)
                ],
              )),
          Positioned(
            bottom: 25,
            left: ClassMediaQuery.screenWidth / 3.5,
            width: ClassMediaQuery.screenWidth / 1.8,
            child: Text(
              "Important: This card is issued by Paytend Europe UAB pursuant to license by VISA.",
              style: AppTheme.white10Regular,
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
