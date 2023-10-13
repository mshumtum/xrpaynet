import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/LifeStylePlusCards.dart';
import 'package:xr_paynet/components/screens/appliedCardScreens/LifeStylePlusApplied.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class LspSuccessScreen extends StatelessWidget {
  static const String routeName = '/life_style_plus_success';
  dynamic? arguments;
  LspSuccessScreen({super.key, this.arguments});

  final NavigationService _navigationService = locator<NavigationService>();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   dynamic params = widget.arguments;
  //   // isFrom = params["isFrom"];
  //
  //   isKycRejected = params["isKycRejected"];
  // }

  @override
  Widget build(BuildContext context) {
    print(arguments);
    return Scaffold(
        backgroundColor: AppClr.black,
        body: SizedBox(
          width: ClassMediaQuery.screenWidth,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  Images.thank_you,
                ),
                SizedBox(height: 10),
                Text(
                  "Thank You",
                  style:
                      TextStyle(color: AppClr.white, height: 2.2, fontSize: 24),
                ),
                Text(
                  "Verification In Progress.",
                  style: AppTheme.white16Regular,
                ),
                Text(
                  "Usually takes 24 to 48 hours",
                  style: AppTheme.greyWhite14Regular22,
                ),
                SizedBox(height: 40),
                ButtonPrimary(
                  title: "Done",
                  onClick: () {
                    if (arguments["isKycRejected"]) {
                      //LifeStylePlusApplied
                      _navigationService.navigateWithRemovingAllPrevious(
                        LifeStylePlusCards.routeName,
                      );
                    } else {
                      _navigationService.navigateWithRemovingAllPrevious(
                          LifeStylePlusApplied.routeName,
                          arguments: {"isFrom": "rejected"});
                    }
                  },
                )
              ]),
        ));
  }
}
