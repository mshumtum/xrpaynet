import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class ChoosePaymentOptions extends StatefulWidget {
  final Function(String) onClick;
  const ChoosePaymentOptions({
    super.key,
    required this.onClick,
  });

  @override
  State<ChoosePaymentOptions> createState() => _ChoosePaymentOptionsState();
}

class _ChoosePaymentOptionsState extends State<ChoosePaymentOptions> {
  String selectedOption = "wallet";
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      decoration: BoxDecoration(
          color: AppClr.dialogBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // InkWell(),
            Container(
              padding: EdgeInsets.only(top: 10, right: 10),
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    Images.ic_close,
                    width: 17,
                  )),
            ),
            Text(
              "Choose Payment Option",
              style: AppTheme.white18Medium,
            ),

            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {
                  // setState(() {
                  //   selectedOption = "clubVirtual";
                  // });
                },
                child: _selectPayOption(selectedOption == "wallet", "wallet",
                    "Pay via XRPayNet\nWallet", Images.ic_purchare_xrp),
              ),
              InkWell(
                onTap: () {
                  // setState(() {
                  //   selectedOption = "clubVirtual";
                  // });
                },
                child: _selectPayOption(
                    selectedOption == "token",
                    "token",
                    "Get Free By Purchasing\nXRPayNet Tokens",
                    Images.ic_pay_by_wallet),
              )
            ]),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: ButtonPrimary(
                title: "Continue",
                onClick: () {
                  Navigator.pop(context);
                  widget.onClick(selectedOption);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _selectPayOption(
    isSelected,
    name,
    walletText,
    walletImage,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = name;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? AppClr.blue : AppClr.otpBackground),
          width: ClassMediaQuery.screenWidth / 2.3,
          height: 160,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  walletImage,
                  width: 32,
                ),
                SizedBox(height: 18),
                Text(
                  walletText,
                  style: isSelected
                      ? AppTheme.white14Regular22
                      : AppTheme.greyWhite14Regular22,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )),
    );
  }
}
