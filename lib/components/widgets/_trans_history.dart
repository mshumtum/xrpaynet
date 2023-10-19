import 'package:flutter/material.dart';

import '../../theme/AppTheme.dart';
import '../../theme/Colors.dart';
import '../../theme/Images.dart';

class TransHistory extends StatefulWidget {
  final int itemCount;
  const TransHistory({
    super.key,
    required this.itemCount,
  });

  @override
  State<TransHistory> createState() => _TransHistoryState();
}

class _TransHistoryState extends State<TransHistory> {
  @override
  Widget build(BuildContext context) {
    return _transactionHistoryList();
  }

  Widget _transactionHistoryList() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              //replace your ListView containing widget here
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.itemCount,
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
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    index == 2
                                        ? Images.ic_card_payment
                                        : Images.ic_recharge_payment,
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      index == 2 ? 'Card Payment' : 'Recharge',
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
                            Column(
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
                                index != 2
                                    ? Text(
                                        "0.01 BTC",
                                        style: TextStyle(
                                            color: AppClr.grey,
                                            fontFamily: AppTheme.fontRegular,
                                            fontSize: 12),
                                      )
                                    : Container(),
                              ],
                            )
                          ],
                        ),

                        // Add a divider after each item except the last one
                        if (index < 10 - 1)
                          Container(
                            margin: const EdgeInsets.only(top: 12, bottom: 12),
                            child: const Divider(
                              color: AppClr.greyButton,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
