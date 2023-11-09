import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/ActiveVirtualCards.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/LifeStylePlusCards.dart';
import 'package:xr_paynet/components/screens/homePage/HomePage.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/LifeStylePlusKYC.dart';
import 'package:xr_paynet/components/screens/lifeStylePlusKYC/_link_card.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/user_cubit/user_cubit.dart';
import 'package:xr_paynet/cubits/user_cubit/user_state.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserDataCubit _userDataCubit = locator<UserDataCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //

    //   print("token$token");
    //   if (token == null || token == "") {

    //   } else {

    //   }

    getLoginStatus();
  }

  void getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Constants.accessToken);
    if (token == null || token == "") {
      Future.delayed(const Duration(milliseconds: 3500), () async {
        _navigationService
            .navigateWithRemovingAllPrevious(WelcomeScreen.routeName);
      });
    } else {
      Constants.userAccessToken = token;
      _userDataCubit.getUserDetailsFun(token);
      _navigationService.navigateWithRemovingAllPrevious(HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataCubit, UserState>(
        bloc: _userDataCubit,
        listener: (context, state) async {
          print("=====${state.main.isSuccess}");
          // if (state.main.isSuccess) {
          //   // print("STATE---${}");
          //   if (state.main.userData?.cardInfo?.isNotEmpty ?? false) {
          //     int index = state.main.userData?.cardInfo?.length ?? 0;
          //     for (int i = 0; i < index; i++) {
          //       if (state.main.userData?.cardInfo?[i].status == "ACTIVE") {
          //         if (state.main.userData?.cardInfo?[i].cardType == "VIRTUAL") {
          //           _navigationService.navigateWithRemovingAllPrevious(
          //               ActiveVirtualCards.routeName,
          //               arguments: {
          //                 "isFrom": "lifestyleVirtual",
          //                 "cardId": state.main.userData?.cardInfo?[i].cardId
          //               });
          //         } else {
          //           _navigationService.navigateWithRemovingAllPrevious(
          //               LifeStylePlusCards.routeName);
          //         }
          //         break;
          //       }
          //       // if (state.main.userData?.cardInfo?[i].status == "ACTIVE") {
          //       //   break;
          //       // }
          //     }
          //   } else {
          //     _navigationService
          //         .navigateWithRemovingAllPrevious(HomePage.routeName);
          //     // _navigationService.navigateWithRemovingAllPrevious(LinkCard.routeName);
          //   }
          // }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppClr.black,
            body: Center(
              child: Image.asset(
                Images.icVolta,
                width: 131,
              ),
            ),
          );
        });
  }
}
