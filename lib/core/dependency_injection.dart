import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/cubits/auth_bloc/login_bloc/LoginBloc.dart';
import 'package:xr_paynet/cubits/auth_bloc/register_bloc/RegisterBloc.dart';

import '../constants/constants.dart';
import '../cubits/api_cubit/api_cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/register_cubit/register_cubit.dart';
import 'locator.dart';


class DependencyInjection {
  static init() async {
    await Firebase.initializeApp();
    await _packages();
    await _repos();
    await _cubits();
    await FirebaseAppCheck.instance.activate();
  }


  static _repos() {
    if (!locator.isRegistered<LoginBloc>()) locator.registerLazySingleton<LoginBloc>(() => LoginBloc());
    if (!locator.isRegistered<RegisterBloc>()) locator.registerLazySingleton<RegisterBloc>(() => RegisterBloc());
  }



  static _cubits() async {
    if (!locator.isRegistered<LoginCubit>()) locator.registerLazySingleton<LoginCubit>(() => LoginCubit());
    if (!locator.isRegistered<RegisterCubit>()) locator.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
    if (!locator.isRegistered<ApiCubit>()) locator.registerLazySingleton<ApiCubit>(() => ApiCubit());
  }

  static _packages() async {
    if (!locator.isRegistered<FirebaseFirestore>()) locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    if (!locator.isRegistered<FirebaseAuth>()) locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    if (!locator.isRegistered<FirebaseFunctions>()) locator.registerLazySingleton<FirebaseFunctions>(() => FirebaseFunctions.instance);
    if (!locator.isRegistered<SharedPreferences>()) locator.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  }
}
