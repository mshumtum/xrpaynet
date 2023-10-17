import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../cubits/api_cubit/api_cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';


class DependencyInjection {
  static init() async {
    await Firebase.initializeApp();
    await _packages();
    await _cubits();
    await _main();
    await FirebaseAppCheck.instance.activate();
  }

  static _main() async {}



  static _cubits() async {
    if (!sl.isRegistered<LoginCubit>()) sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
    // if (!sl.isRegistered<RegisterCubit>()) sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
    if (!sl.isRegistered<ApiCubit>()) sl.registerLazySingleton<ApiCubit>(() => ApiCubit());
  }

  static _packages() async {
    if (!sl.isRegistered<FirebaseFirestore>()) sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    if (!sl.isRegistered<FirebaseAuth>()) sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    if (!sl.isRegistered<FirebaseFunctions>()) sl.registerLazySingleton<FirebaseFunctions>(() => FirebaseFunctions.instance);
    if (!sl.isRegistered<SharedPreferences>()) sl.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  }
}
