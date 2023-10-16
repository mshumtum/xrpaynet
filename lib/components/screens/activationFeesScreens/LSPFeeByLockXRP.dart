import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/ActiveVirtualCards.dart';
import 'package:xr_paynet/components/screens/appliedCardScreens/LifeStylePlusApplied.dart';
import 'package:xr_paynet/components/screens/chooseOptionScreens/ChooseCurrency.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_heading_text.dart';
import 'package:xr_paynet/components/widgets/drop_down.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Constants.dart';
import 'package:xr_paynet/theme/Images.dart';

class LSPFeeByLockXRP extends StatefulWidget {
  static const String routeName = '/life_style_plus_lock_xrp';
  final Object? arguments;
  const LSPFeeByLockXRP({super.key, this.arguments});

  @override
  State<LSPFeeByLockXRP> createState() => _LSPFeeByLockXRPState();
}

class _LSPFeeByLockXRPState extends State<LSPFeeByLockXRP> {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isClubCard = true;
  String cardType = "virtual";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var params = (widget?.arguments as Map);

    setState(() {
      isClubCard = params?["isFrom"] == "lifestyleVirtual" ? false : true;
      cardType = params?["cardType"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SingleChildScrollView(
            child: Column(children: [
          Header(
            title: "Lock XRPayNet",
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
                  Text("1000 XRPayNet", style: AppTheme.white24Regular),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$ 250",
                    style: AppTheme.lightBlueText20Regular,
                  ),
                ]),
          ),
          SizedBox(height: 25),
          _details(),
          Container(
            padding: EdgeInsets.symmetric(vertical: isClubCard ? 70 : 37),
            child: Image.asset(
              Images.ic_xrpaynet_bg,
              width: ClassMediaQuery.screenWidth / 1.5,
              height: 80,
            ),
          ),
          Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 28, left: 13, right: 13),
              decoration: BoxDecoration(
                  color: AppClr.darkRed,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                Constants.lockXRPRToken,
                style: AppTheme.white12Light22,
              )),
          ButtonPrimary(
            onClick: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return CongratulationDialog(
                        title: "Congratulations",
                        descriptions:
                            "Your tokens are locked and your card will be issued shortly",
                        doneTxt: "Done",
                        lottieFile: Images.paySuccessLottie,
                        onClick: () {
                          Navigator.of(context).pop();
                          if (cardType == "virtual") {
                            _navigationService.navigateWithRemovingAllPrevious(
                                ActiveVirtualCards.routeName,
                                arguments: {
                                  "isFrom": isClubCard
                                      ? "clubVirtual"
                                      : "lifestyleVirtual"
                                });
                          } else {
                            _navigationService.navigateWithRemovingAllPrevious(
                                LifeStylePlusApplied.routeName,
                                arguments: {"isFrom": "registerUser"});
                          }
                        });
                  });
            },
            title: "Buy Now",
            horizontal: 12,
          ),
          SizedBox(height: 15),
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
            color: AppClr.greyQrBack,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              _types('Locking Period', '45 Days'),
              Divider(color: AppClr.grey2, height: 1),
              _types('Lock Amount', '900 XRPayNet'),
              isClubCard
                  ? Container()
                  : Column(
                      children: [
                        Divider(color: AppClr.grey2, height: 1),
                        _types('Maintenance Fee', '100 XRPayNet'),
                        Divider(color: AppClr.grey2, height: 1),
                        _types('Total Amount', '1000 XRPayNet'),
                      ],
                    ),
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
