import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../core/Locator.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {

  final FirebaseFunctions _firebaseFunctions = locator<FirebaseFunctions>();
  ApiCubit() : super(const ApiInitial());

  getUserDetails() async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable('getUserDetails');
      HttpsCallableResult result = await callable.call();
      log("Function called successfully. Result: ${result.data}");
    } catch (e) {
      if (e is FirebaseFunctionsException) {
        log("Function Error: ${e.code}\n${e.message}\n${e.details}");
      } else {
        log("General error: $e");
      }
    }
  }
}
