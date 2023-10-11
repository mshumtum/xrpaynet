import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCurrency.dart';
import 'package:xr_paynet/components/screens/deposit/Deposit.dart';
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

class LifeStylePlusFees extends StatefulWidget {
  static const String routeName = '/purchase_life_style_plus';
  final Object? arguments;
  const LifeStylePlusFees({
    super.key,
    this.arguments,
  });

  @override
  State<LifeStylePlusFees> createState() => _LifeStylePlusFeesState();
}

class _LifeStylePlusFeesState extends State<LifeStylePlusFees> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SingleChildScrollView(
            child: Column(children: [
          Header(
            title: "Activation Fee",
            secondaryButtonImg: Images.ic_deposit,
            secondaryButtonText: "Deposit",
            secondaryClick: () {
              _navigationService.navigateWithBack(Deposit.routeName,
                  arguments: null);
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: ClassMediaQuery.screenWidth,
            child: const HeadingText(
              title: 'Choose Currency',
            ),
          ),
          DropDownField(
            value: "USDT",
            onClick: () {
              _navigationService.navigateWithBack(ChooseCurrency.routeName);
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10, top: 27),
            height: 110,
            width: ClassMediaQuery.screenWidth,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppClr.cardGradient, AppClr.cardGradient1],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Column(
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
                  style: AppTheme.resendGreyText16,
                ),
                Text(
                  "1000 USDT",
                  style: AppTheme.white16Regular,
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          _details(),
          Container(
            padding: const EdgeInsets.only(top: 80, bottom: 42),
            child: Image.asset(
              Images.ic_xrpaynet_bg,
              width: ClassMediaQuery.screenWidth / 1.5,
              height: 80,
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

  Widget _details() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppClr.inputFieldBg,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              _types('Issuance Fee', '\$ 150'),
              Divider(color: AppClr.grey2, height: 1),
              _types('Maintenance Fee', '\$ 50'),
              Divider(color: AppClr.grey2, height: 1),
              _types('Total Amount', '\$ 200'),
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
          Text(type, style: AppTheme.greyText14Regular),
          Text(value, style: AppTheme.white14Regular22),
        ],
      ),
    );
  }
}
