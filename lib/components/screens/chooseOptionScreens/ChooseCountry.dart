import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_circle_container.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyPhysicalCardCubit.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/responses/CountryListResponse.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class ChooseCountry extends StatefulWidget {
  String countryName;
  ChooseCountry({super.key, required this.countryName});

  @override
  State<ChooseCountry> createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  List<CountryListResult> tempArray = [];
  List<CountryListResult> array = [];
  String selectedItem = "";
  bool isSearchVisible = false;
  final ApplyPhysicalCardCubit _applyPhysicalCardCubit =
      locator<ApplyPhysicalCardCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tempArray = _applyPhysicalCardCubit.state.main.countryList?.result ?? [];
      array = _applyPhysicalCardCubit.state.main.countryList?.result ?? [];
      selectedItem = widget.countryName;
    });
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
            Header(
              title: "Country",
              secondaryButtonImg: Images.ic_search,
              secondaryClick: () {
                setState(() {
                  isSearchVisible = true;
                });
              },
            ),
            isSearchVisible
                ? SearchField(
                    hintText: "Search",
                    onSearchText: (text) {
                      List<CountryListResult> array1 = tempArray.where((item) {
                        var countryName = item.english ?? "";
                        return countryName
                            .toLowerCase()
                            .startsWith(text.toLowerCase());
                      }).toList();
                      setState(() {
                        array = array1;
                      });
                    })
                : Container(),
            _currencyList(),
            ButtonPrimary(
                title: 'Done',
                onClick: () {
                  Navigator.pop(context, selectedItem);
                  // _navigationService.navigateWithRemovingAllPrevious(Deposit.routeName, arguments: array[selectedIndex]);
                }),
          ],
        ),
      ),
    );
  }

  Widget _currencyList() {
    return Container(
      height: ClassMediaQuery.screenHeight / (isSearchVisible ? 1.3 : 1.2),
      width: ClassMediaQuery.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListView.builder(
        itemCount: array.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  setState(() {
                    selectedItem = array[index].english ?? "";
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(100.0),
                        //     child: SvgPicture.network(
                        //       array[index].flag ??
                        //           "https://twemoji.maxcdn.com/2/svg/1f1f7-1f1fa.svg",
                        //       width: 50,
                        //       height: 50,
                        //     )),

                        ClipOval(
                          child: Container(
                            width: 38,
                            height: 38,
                            color: AppClr.dialogBackground,
                            child: SvgPicture.network(
                              "https://hatscripts.github.io/circle-flags/flags/" +
                                  array[index].iso3166Alpha2!.toLowerCase() +
                                  ".svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: ClassMediaQuery.screenWidth / 1.5,
                          child: Text(
                            array[index].english ?? "",
                            style: const TextStyle(
                              color: AppClr.grey,
                              fontSize: 14,
                              fontFamily: AppTheme.fontRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Show the tick icon if the item is selected
                    if (selectedItem == array[index].english)
                      Image.asset(
                        Images.ic_blue_tick,
                        width: 13,
                        height: 13,
                      )
                  ],
                ),
              ),
              // Add a divider after each item except the last one
              if (index < array.length - 1)
                Divider(
                  color: AppClr.greyButton,
                ),
            ],
          );
        },
      ),
    );
  }
}
