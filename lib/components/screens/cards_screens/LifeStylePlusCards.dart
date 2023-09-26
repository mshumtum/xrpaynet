import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/transaction_history/TransactionHistory.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../../core/Locator.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../theme/Images.dart';
import '../../utilities/ClassMediaQuery.dart';
import '../../widgets/_trans_history.dart';
import '../../widgets/top_hearder_icons.dart';

class LifeStylePlusCards extends StatefulWidget {
  const LifeStylePlusCards({Key? key}) : super(key: key);

  @override
  State<LifeStylePlusCards> createState() => _LifeStylePlusCardsState();
}

class _LifeStylePlusCardsState extends State<LifeStylePlusCards> {
  bool isPhysicalCardSelected = true;
  bool isFrontSideVisible = true;
  final NavigationService _navigationService = locator<NavigationService>();

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
              onClickLeftIcon: () {},
              onClickRightIcon: () {},
            ),
            const SizedBox(
              height: 35,
            ),
            _cardSelection(),
            isFrontSideVisible ? _frontCardImage() : _backCardImage(),
            const SizedBox(
              height: 10,
            ),
            ButtonPrimary(
              title: 'Recharge',
              onClick: () {},
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

  Widget _frontCardImage() {
    return Container(
      height: 250,
      width: ClassMediaQuery.screenWidth,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            child: Image.asset(Images.card_front_img),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, right: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isFrontSideVisible = false;
                  });
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
          SizedBox(
            height: 250,
            child: Image.asset(Images.card_back_img),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 78, right: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isFrontSideVisible = true;
                  });
                },
                child: Text(
                  'BACK TO MAIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppTheme.fontBold),
                ),
              ),
            ),
          ),
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
      margin:  const EdgeInsets.symmetric(horizontal: 15),
      width: ClassMediaQuery.screenWidth,
      child:  Row(
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
              _navigationService.navigateWithBack(TransactionHistory.routeName);
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
