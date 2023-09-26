import 'package:flutter/material.dart';
import 'package:xr_paynet/components/screens/deposit/Deposit.dart';
import 'package:xr_paynet/components/utilities/ClassMediaQuery.dart';

import '../../../core/Locator.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../theme/AppTheme.dart';
import '../../../theme/Colors.dart';
import '../../../theme/Images.dart';
import '../../widgets/_button_primary.dart';
import '../../widgets/_header.dart';

class ChooseCurrency extends StatefulWidget {
  static const String routeName = '/choose_currency_page';

  const ChooseCurrency({Key? key}) : super(key: key);

  @override
  State<ChooseCurrency> createState() => _ChooseCurrencyState();
}

class _ChooseCurrencyState extends State<ChooseCurrency> {
  final List<String> array  = <String> [
    "USDT (ERC20)",
    "USDT (TRC20)",
    "USDT (ERC20)",
    "USDT (TRC20)",
    "USDT",
    "ETH",
    "BTC",
    "BNB",
    "USDT (ERC20)",
    "USDT (TRC20)",
    "USDT (ERC20)",
    "USDT (TRC20)",
    "USDT",
    "ETH",
    "BTC",
    "BNB"
  ];

  // List<bool> selectedItems = List.filled(8, false);
  List<String> items = List.generate(50, (index) => 'Item $index');
  List<bool> selectedItems = List.generate(50, (index) => false);
  int selectedIndex = -1;

  final  NavigationService _navigationService = locator<NavigationService>();


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
              title: "Choose Currency",
            ),
            const SizedBox(
              height: 10,
            ),
            _currencyList(),


            ButtonPrimary(
                title: 'Done',
                onClick: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Deposit( arguments: array[selectedIndex],),
                    ),
                  );
                  // _navigationService.navigateWithRemovingAllPrevious(Deposit.routeName, arguments: array[selectedIndex]);
                }),
          ],
        ),
      ),
    );
  }

  Widget _currencyList (){
    return Container(
      height: ClassMediaQuery.screenHeight / 1.2,
      width: ClassMediaQuery.screenWidth,
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: array.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  setState(() {
                    if (selectedIndex == index) {
                      // Deselect if the same item is tapped again
                      selectedIndex = -1;
                    } else {
                      selectedIndex = index;
                    }
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
                          child: Image.asset(
                            Images.ic_usdt,
                            width: 25,
                            height: 25,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          array[index],
                          style: const TextStyle(
                            color: AppClr.grey,
                            fontSize: 14,
                            fontFamily: AppTheme.fontRegular,
                          ),
                        ),
                      ],
                    ),
                    // Show the tick icon if the item is selected
                    if (selectedIndex == index)
                      Image.asset(
                        Images.ic_blue_tick,
                        width: 13,
                        height: 13,
                      )
                  ],
                ),
              ),
              // Add a divider after each item except the last one
              if (index < array.length - 1) Divider(color: AppClr.greyButton,),
            ],
          );
        },
      ),
    );
  }

}
