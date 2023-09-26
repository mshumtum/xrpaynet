import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/cards_screens/VirtualCard.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_circle_container.dart';
import 'package:xr_paynet/components/widgets/top_hearder_icons.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../../core/Locator.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../theme/Images.dart';
import '../../widgets/_button_primary.dart';

class ClubCard extends StatefulWidget {
  const ClubCard({Key? key}) : super(key: key);

  @override
  State<ClubCard> createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
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
              title: 'Club Card',
              rightIcon: Images.ic_logout,
              onClickLeftIcon: () {},
              onClickRightIcon: () {},
            ),
            _cardImg(),
            _details(),
             const SizedBox(height: 25,),
            _certified(),
            const SizedBox(height: 25,),
            ButtonPrimary(
                title: 'Apply Now',
                onClick: () {
                  _navigationService.navigateWithBack(VirtualCard.routeName);
                }),

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
      child: Image.asset(Images.xr_pay_net_card),
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
      height: 180,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppClr.blue_gradient, AppClr.black_gradient],
            // Replace with your desired colors
            begin: Alignment.topRight,
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
              _rules('No Annual Fee'),
              const SizedBox(
                height: 20,
              ),
              _rules(
                  'Includes a \$10 Top-Up automatically added to the\ncard on activation'),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }

  Widget _applePayAndGooglePay() {
    return Row(
      children: [
        const CircleContainer(
          containerSize: 8.0,
        ),
        const SizedBox(width: 15,),

        Image.asset(
          Images.apple_pay_img,
          width: 38,
          height: 16,
        ),
        const SizedBox(width: 5,),
        _text('&'),
        const SizedBox(width: 5,),

        Image.asset(
          Images.gPay_img,
          width: 38,
          height: 16,
        ),
        const SizedBox(width: 5,),
        _text('Certified'),
      ],
    );
  }

  Widget _rules(value) {
    return Row(
      children: [
        const CircleContainer(
          containerSize: 8.0,
        ),
        const SizedBox(width: 15,),
        _text(value),
      ],
    );
  }

  Widget _text(value) {
    return Text(
      value,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: AppClr.white,
          fontSize: 14,
          fontFamily: AppTheme.fontRegular),
    );
  }
}
