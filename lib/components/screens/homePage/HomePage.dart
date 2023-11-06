import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/LifeStylePlusApply.dart';
import 'package:xr_paynet/components/screens/activeCardScreens/LifeStylePlusCards.dart';
import 'package:xr_paynet/components/screens/cardsApplyScreens/VirtualCardApply.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/utilities/utility.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_congratulation_dialog.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/user_cubit/user_cubit.dart';
import 'package:xr_paynet/cubits/user_cubit/user_state.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavigationService navigationService = locator<NavigationService>();
  final UserDataCubit _userDataCubit = locator<UserDataCubit>();

  var selectedCard = "lifestylePhysical";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var token = Constants.userAccessToken;
    print('TOKEM======== $token');
    _userDataCubit.getCardListing();
    _userDataCubit.getUserDetailsFun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppClr.black,
        body: BlocConsumer<UserDataCubit, UserState>(
            bloc: _userDataCubit,
            listener: (context, state) async {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      title: "XRPayNet Cards",
                      isHideBack: false,
                      secondaryButtonImg: Images.ic_logout,
                      secondaryClick: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmationDialog(
                                  descriptions:
                                      "Are you sure you want to logout?",
                                  doneTxt: "Done",
                                  lottieFile: Images.logoutFileLottie,
                                  onClick: () {
                                    clearXrPayData(context);
                                    Navigator.of(context).pop();
                                    navigationService
                                        .navigateWithRemovingAllPrevious(
                                            WelcomeScreen.routeName);
                                  });
                            });
                      },
                    ),
                    Container(
                      width: ClassMediaQuery.screenWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Select Card Type",
                            style: AppTheme.white18Regular,
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCard = "clubVirtual";
                                  });
                                },
                                child: _virtualCardView(
                                    selectedCard == "clubVirtual",
                                    "CLUB \$ 24.00",
                                    Images.ic_virtual_club),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCard = "lifestyleVirtual";
                                  });
                                },
                                child: _virtualCardView(
                                    selectedCard == "lifestyleVirtual",
                                    "LIFESTYLE \$ 49.00",
                                    Images.ic_virtual_lifestyle),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedCard = "lifestylePhysical";
                              });
                            },
                            child: _physicalCardView(
                                selectedCard == "lifestylePhysical"),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                    ButtonPrimary(
                      title: "Continue",
                      onClick: () {
                        if (!_userDataCubit.state.main.loading) {
                          if (selectedCard == "clubVirtual" ||
                              selectedCard == "lifestyleVirtual") {
                            navigationService.navigateWithBack(
                                VirtualCardApply.routeName,
                                arguments: {
                                  "isFrom": selectedCard,
                                  "cardInfo": _userDataCubit.state.main
                                          .cardListingResponse?.result?[
                                      selectedCard == "clubVirtual" ? 0 : 1]
                                });
                          } else if (selectedCard == "lifestylePhysical") {
                            navigationService.navigateWithBack(
                                LifeStylePlusApply.routeName,
                                arguments: {
                                  "cardInfo": _userDataCubit.state.main
                                      .cardListingResponse?.result?[2]
                                });
                          }
                        }
                        //ClubCard
                      },
                      buttonColor: _userDataCubit.state.main.loading
                          ? AppClr.grey
                          : AppClr.blue,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              );
            }));
  }

  Widget _virtualCardView(isSelected, cardType, cardImage) {
    return _userDataCubit.state.main.loading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade900,
            highlightColor: Colors.grey.shade800,
            child: Container(
              height: 310,
              width: ClassMediaQuery.screenWidth / 2.3,
              color: AppClr.black,
            ),
          )
        : Container(
            height: 310,
            width: ClassMediaQuery.screenWidth / 2.3,
            decoration: isSelected
                ? AppTheme.selectedCardXrPay
                : AppTheme.unselectedCardXrPay,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Virtual",
                      style: isSelected
                          ? AppTheme.white14Regular
                          : AppTheme.greyText14Regular),
                  Image.asset(cardImage, height: 240),
                  Text(cardType,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? AppClr.white : AppClr.greyText,
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.w500,
                      ))
                ]),
          );
  }

  Widget _physicalCardView(
    isSelected,
  ) {
    return _userDataCubit.state.main.loading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade900,
            highlightColor: Colors.grey.shade800,
            child: Container(
              height: 300,
              width: ClassMediaQuery.screenWidth / 1.1,
              color: AppClr.black,
            ),
          )
        : Container(
            height: 300,
            width: ClassMediaQuery.screenWidth / 1.1,
            decoration: selectedCard == "lifestylePhysical"
                ? AppTheme.selectedCardXrPay
                : AppTheme.unselectedCardXrPay,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: ClassMediaQuery.screenWidth / 2.2,
                  padding: EdgeInsets.only(top: 28),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(left: 3),
                      alignment: Alignment.bottomRight,
                      child: Text("LIFESTYLE PLUS \$ 99.00",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? AppClr.white : AppClr.greyText,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w500,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Text("Physical",
                              style: isSelected
                                  ? AppTheme.white14Regular
                                  : AppTheme.greyText14Regular),
                          SizedBox(
                            height: 14,
                          ),
                          Image.asset(
                            Images.ic_physical_ls,
                            width: ClassMediaQuery.screenWidth / 2.6,
                          ),
                          // SizedBox(width: 30),
                          //
                        ],
                      ),
                    )
                  ]),
                ),
                Text("+", style: AppTheme.white18Regular),
                Container(
                  width: ClassMediaQuery.screenWidth / 2.6,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Virtual",
                            style: isSelected
                                ? AppTheme.white14Regular
                                : AppTheme.greyText14Regular),
                        Image.asset(Images.ic_virtual_ls, height: 250),
                      ]),
                )
              ],
            ),
          );
  }
}
