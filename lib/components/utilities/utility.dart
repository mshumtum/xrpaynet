import 'dart:io';

import 'package:flutter/cupertino.dart';


  //Check for internet Connection
  Future<bool> isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
//this is used to hide loader as well as close dialogs
hideLoader(BuildContext context){
  Navigator.of(context, rootNavigator: true).pop();
}
// this method is used to close only the bottom sheet
closeBottomSheet(BuildContext context){
  Navigator.pop(context);
}