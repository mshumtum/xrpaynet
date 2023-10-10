import 'package:flutter/material.dart';
import 'package:xr_paynet/theme/AppTheme.dart';

import '../../core/network/message.dart';
import '../utilities/ClassMediaQuery.dart';

internetFailure(context, Function() onclick) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return internetFailureWidget(message: CONNECTION_ERROR, onclick: onclick);
    },
  );
}

Widget internetFailureWidget({required String message, required Function() onclick}) {
  return SizedBox(
    height: ClassMediaQuery.blockSizeVertical * 40,
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_off,
                color: whiteBtnColor,
              ),
              const SizedBox(
                width: 30,
              ),
              Icon(
                Icons.signal_cellular_connected_no_internet_4_bar,
                color: whiteBtnColor,
              )
            ],
          ),
          separatorLineText('Neither Wifi Nor Data'),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 40.0,
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: InkWell(
              onTap: onclick,
              child: Container(
                color: whiteBtnColor,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Retry',
                    style:  TextStyle(
                      fontFamily: AppTheme.fontBold,
                      color: Colors.grey,
                      fontSize: 12,
                    )
                ),

              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget separatorLineText(String text) {
  return Row(children: <Widget>[
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 50.0, right: 5.0),
          child: const Divider(
            color: Colors.grey,
            height: 50,
          )),
    ),
    Text(
      text,
      style: const TextStyle(
        fontFamily: AppTheme.fontMedium,
        color: Colors.grey,
        fontSize: 12,
      ),
    ),
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 50.0),
          child: const Divider(
            color: Colors.grey,
            height: 50,
          )),
    ),
  ]);
}

// red button color
var whiteBtnColor = Colors.white;