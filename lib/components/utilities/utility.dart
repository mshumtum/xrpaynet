import 'dart:io';
import 'package:flutter/material.dart';

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

bool isEmailValid(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}

bool isPasswordValid(String password) {
  // Define the regex pattern for a valid password
  const pattern = r'^(?=.*[A-Z])(?=.*[.!@#$&*])(?=.{6,128}).*$';
  final regExp = RegExp(pattern);

  // Use the RegExp.hasMatch() method to check if the password matches the pattern
  return regExp.hasMatch(password);
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
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
            Text(message),
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
            Text(message),
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
