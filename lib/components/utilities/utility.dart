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

// bool isEmailValid(String em) {
//   const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
//       r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
//       r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
//       r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
//       r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
//       r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
//       r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
//
//   RegExp regExp = RegExp(pattern);
//
//   return regExp.hasMatch(em);
// }
//
// bool isPasswordValid(String password) {
//   // Define the regex pattern for a valid password
//   const pattern = r'^(?=.*[A-Z])(?=.*[.!@#$&*])(?=.{6,128}).*$';
//   final regExp = RegExp(pattern);
//   return regExp.hasMatch(password);
// }

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
