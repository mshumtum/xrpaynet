import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/components/screens/WelcomeScreens/WelcomeScreen.dart';
import 'package:xr_paynet/constants/Constants.dart';
import 'package:xr_paynet/core/Locator.dart';
import 'package:xr_paynet/core/navigation/navigation_service.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
hideLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

// this method is used to close only the bottom sheet
closeBottomSheet(BuildContext context) {
  Navigator.pop(context);
}

void showError(BuildContext context, String message) {

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        // key: _scaffoldKey,
        content: Row(
          children: [Expanded(child: Text(message)), const Icon(Icons.error)],
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
}

void showLoadingBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                message,
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
}

void showSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                message,
              ),
            ),
            Icon(Icons.check),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
}

void hideSnackBar(context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}

Future<bool> hideSnackBar1(context, type) async {
  if (type == 1) {
    final NavigationService _navigationService = locator<NavigationService>();
    _navigationService.goBack();
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return true;
}

Future<void> clearXrPayData(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(Constants.accessToken, '');
}

String toFixed(value, fixed){
  return  double.parse(value).toStringAsFixed(fixed);
}