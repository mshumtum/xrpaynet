import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/AppTheme.dart';
import 'package:xr_paynet/theme/Colors.dart';

import '../../../theme/Images.dart';
import '../../widgets/_header.dart';
import '../../widgets/_trans_history.dart';

class TransactionHistory extends StatefulWidget {
  static const String routeName = '/trans_history';

  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppClr.black,
      body: Column(
        children: [
          const Header(
            title: "Transaction History",
          ),
          _transactionHistoryList(),
        ],
      ),
    );
  }
  Widget _transactionHistoryList() {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 25, // Reduced height here
                                width: 25, // Reduced width here
                                child: Image.asset(
                                  Images.ic_recharge_payment,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recharge',
                                    style: TextStyle(
                                        color: AppClr.white,
                                        fontSize: 14,
                                        fontFamily: AppTheme.fontMedium,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Aug 19, 2023',
                                    style: TextStyle(
                                      color: AppClr.grey,
                                      fontSize: 12,
                                      fontFamily: AppTheme.fontRegular,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          // Show the tick icon if the item is selected
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("\$ 100",
                                  style: TextStyle(
                                      color: AppClr.white,
                                      fontFamily: AppTheme.fontMedium,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "0.01 BTC",
                                style: TextStyle(
                                    color: AppClr.grey,
                                    fontFamily: AppTheme.fontRegular,
                                    fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      // Add a divider after each item except the last one
                      if (index < 10 - 1)
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: const Divider(
                            color: AppClr.greyButton,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
