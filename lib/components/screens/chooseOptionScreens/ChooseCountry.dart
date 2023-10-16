import 'package:flutter/material.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';
import 'package:xr_paynet/components/widgets/_button_primary.dart';
import 'package:xr_paynet/components/widgets/_circle_container.dart';
import 'package:xr_paynet/components/widgets/_header.dart';
import 'package:xr_paynet/components/widgets/_input_filed.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';
import 'package:xr_paynet/theme/Images.dart';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({super.key});

  @override
  State<ChooseCountry> createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  List<String> tempArray = <String>[
    "England",
    "United States Of America",
    "China",
    "Japan",
    "Korea",
    "Turkey",
    "India",
    "Russia",
    "Spain",
    "Indonesia"
  ];
  List<String> array = <String>[];
  String selectedItem = "England";
  bool isSearchVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      array = tempArray;
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
                      List<String> array1 = tempArray.where((item) {
                        return item
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
                    // if (selectedItem == array[index]) {
                    //   // Deselect if the same item is tapped again
                    //   selectedIndex = -1;
                    // } else {
                    //   selectedIndex = index;
                    // }
                    selectedItem = array[index];
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: CircleImage(
                              url:
                                  "https://cdn.britannica.com/25/4825-004-F1975B92/Flag-United-Kingdom.jpg",
                            )),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: ClassMediaQuery.screenWidth / 1.5,
                          child: Text(
                            array[index],
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
                    if (selectedItem == array[index])
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
