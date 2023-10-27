import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCurrency.dart';
import 'package:xr_paynet/components/screens/deposit/Deposit.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/components/widgets/drop_down.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class CardRecharge extends StatefulWidget {
  static const String routeName = '/card_recharge';

  final Object? arguments;
  const CardRecharge({super.key, this.arguments});

  @override
  State<CardRecharge> createState() => _CardRechargeState();
}

class _CardRechargeState extends State<CardRecharge> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SingleChildScrollView(
            child: Column(children: [
          Header(
            title: "Card Recharge",
            secondaryButtonImg: Images.ic_deposit,
            secondaryButtonText: "Deposit",
            secondaryClick: () {
              _navigationService.navigateWithBack(Deposit.routeName,
                  arguments: null);
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 35),
            width: ClassMediaQuery.screenWidth,
            child: const HeadingText(
              title: 'Choose Currency',
            ),
          ),
          DropDownField(
            value: "USDT (ERC20)",
            onClick: () {
              _navigationService.navigateWithBack(ChooseCurrency.routeName);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Stack(
            children: [
              InputField(
                inputLabel: "Enter Amount",
                hintText: 'USD Amount',
              ),
              Positioned(
                child: Container(
                  color: AppClr.inputFieldBg,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text("USD", style: AppTheme.white16w500),
                ),
                // child:
                bottom: 14,
                right: 30,
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Deposit Fee: ",
                  style: AppTheme.resendGreyText14,
                ),
                Text(
                  "\$ 1",
                  style: AppTheme.white14Regular,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10, top: 30),
            height: 130,
            width: ClassMediaQuery.screenWidth,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppClr.cardGradient, AppClr.cardGradient1],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("200 USDT", style: AppTheme.white24Regular),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$ 200",
                    style: AppTheme.lightBlueText20Regular,
                  ),
                ]),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20.0, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Available Balance: ",
                  style: AppTheme.resendGreyText18,
                ),
                Text(
                  "1000 USDT",
                  style: AppTheme.white18Regular,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Image.asset(
              Images.ic_xrpaynet_bg,
              width: ClassMediaQuery.screenWidth / 1.5,
            ),
          ),
          ButtonPrimary(
            onClick: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return CongratulationDialog(
                        title: "Congratulations",
                        descriptions:
                            "Payment has been confirmed, balance in your card will reflect shortly",
                        doneTxt: "Done",
                        lottieFile: Images.paySuccessLottie,
                        onClick: () {
                          Navigator.of(context).pop();
                          _navigationService.goBack();
                        });
                  });
            },
            title: "Pay Now",
          )
        ])));
  }
}
