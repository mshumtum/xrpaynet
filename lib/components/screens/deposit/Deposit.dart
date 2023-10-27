import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCurrency.dart';
import 'package:xr_paynet/components/screens/deposit/SetAmountDialog.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';
import 'package:xr_paynet/components/widgets/drop_down.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/Locator.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../theme/Images.dart';
import '../../widgets/_button_primary.dart';
import '../../widgets/_header.dart';

class Deposit extends StatefulWidget {
  static const String routeName = '/deposit_page';

  final String arguments;

  const Deposit({required this.arguments});

  @override
  State<Deposit> createState() => _DepositState(response: arguments);
}

class _DepositState extends State<Deposit> {
  final NavigationService _navigationService = locator<NavigationService>();
  String response = "";
  String amount = "";
  var userAddress = "0x5c17613C5ad1e3543c1E3989BD3E09D442620d2b";
  String get argRes => response;
  _DepositState({required this.response});
  @override
  void initState() {
    super.initState();
    print("Received argument: ${widget.arguments}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(
              title: "Deposit",
            ),
            Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                _qrImage(),
                const SizedBox(
                  height: 25,
                ),
                amount != ""
                    ? _balance(amount + " USDT", " = \$ " + amount, 18.0)
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                _addressCopy(),
                const SizedBox(
                  height: 15,
                ),
                _balance("Balance: ", "200 USDT", 14.0),
                const SizedBox(
                  height: 40,
                ),
                _setAmountShare(),
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
                    _navigationService
                        .navigateWithBack(ChooseCurrency.routeName);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const HeadingText(
                  title:
                      'Once the fee payment is confirmed, your card \nwill be activated',
                  color: AppClr.white,
                  textAlign: TextAlign.center,
                  textSize: 16,
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonPrimary(
                    title: 'Done',
                    onClick: () {
                      _navigationService.goBack();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _qrImage() {
    return Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppClr.greyQrBack,
        ),
        child: QrImageView(
          data: userAddress,
          version: QrVersions.auto,
          size: 200.0,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Colors.white,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Colors.white,
          ),
        ));
  }

  Widget _addressCopy() {
    return SizedBox(
      width: ClassMediaQuery.screenWidth / 1.45,
      child: Row(children: [
        Expanded(
          child: Text(userAddress,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.greyWhite16Regular),
        ),
        const SizedBox(
          width: 9,
        ),
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: userAddress)).then((res) {});
          },
          child: Image.asset(
            Images.icCopy,
            width: 13,
          ),
        )
      ]),
    );
  }

  Widget _balance(title, value, fontSize) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
          color: AppClr.grey2,
          fontSize: 14.0,
          fontFamily: AppTheme.fontRegular,
        ),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                color: AppClr.grey,
                fontSize: fontSize,
                fontWeight: FontWeight.w300),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
                color: AppClr.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _setAmountShare() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(children: [
        InkWell(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return SetAmountDialog(
                    amount: amount,
                    onConfirm: (value) {
                      var addressAmount =
                          'usdt:0xE53dC38c6F68E3d0dd3Cf00459DD94401EBdFdcC?amount=' +
                              value;
                      setState(() {
                        amount = value;
                        userAddress = addressAmount;
                      });
                      //
                    },
                  );
                });
          },
          child: Image.asset(
            Images.icSetAmount,
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Set Amount',
          style: TextStyle(
              color: AppClr.white, fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      ]),
      const SizedBox(
        width: 56,
      ),
      Column(children: [
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: userAddress)).then((res) {});
          },
          child: Image.asset(
            Images.icShareBtn,
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Share',
          style: TextStyle(
              color: AppClr.white, fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
      ]),
    ]);
  }
}
