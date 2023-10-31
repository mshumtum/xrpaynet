import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyPhysicalCardCubit.dart';
import 'package:xr_paynet/cubits/card_apply_cubit/applyVirtualCardCubit.dart';
import 'package:xr_paynet/cubits/card_login_cubit/card_login_cubit.dart';
import 'package:xr_paynet/cubits/card_register_cubit/card_register_cubit.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/create_forgot_password.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/forgot_password_cubit.dart';
import 'package:xr_paynet/cubits/email_verification_cubit/verify_email_cubit.dart';

import '../constants/FormSubmissionStatus.dart';
import '../cubits/api_cubit/api_cubit.dart';
import 'locator.dart';

class DependencyInjection {
  static init() async {
    await Firebase.initializeApp();
    await _packages();
    await _cubits();
    await FirebaseAppCheck.instance.activate();
  }

  static _cubits() async {
    if (!locator.isRegistered<CardLoginCubit>())
      locator.registerLazySingleton<CardLoginCubit>(() => CardLoginCubit());
    if (!locator.isRegistered<CardRegisterCubit>())
      locator
          .registerLazySingleton<CardRegisterCubit>(() => CardRegisterCubit());
    if (!locator.isRegistered<ApiCubit>())
      locator.registerLazySingleton<ApiCubit>(() => ApiCubit());

    if (!locator.isRegistered<VerifyEmailCubit>())
      locator.registerLazySingleton<VerifyEmailCubit>(() => VerifyEmailCubit());
    if (!locator.isRegistered<ForgotPasswordCubit>()) {
      locator.registerLazySingleton<ForgotPasswordCubit>(
          () => ForgotPasswordCubit());
    }
    if (!locator.isRegistered<CreateForgotPassCubit>()) {
      locator.registerLazySingleton<CreateForgotPassCubit>(
          () => CreateForgotPassCubit());
    }
    if (!locator.isRegistered<ApplyVirtualCardCubit>()) {
      locator.registerLazySingleton<ApplyVirtualCardCubit>(
          () => ApplyVirtualCardCubit());
    }
    if (!locator.isRegistered<ApplyPhysicalCardCubit>()) {
      locator.registerLazySingleton<ApplyPhysicalCardCubit>(
          () => ApplyPhysicalCardCubit());
    }
  }

  static _packages() async {
    if (!locator.isRegistered<FirebaseFirestore>())
      locator.registerLazySingleton<FirebaseFirestore>(
          () => FirebaseFirestore.instance);
    if (!locator.isRegistered<FirebaseAuth>())
      locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    if (!locator.isRegistered<FirebaseFunctions>())
      locator.registerLazySingleton<FirebaseFunctions>(
          () => FirebaseFunctions.instance);
    if (!locator.isRegistered<SharedPreferences>())
      locator.registerSingletonAsync<SharedPreferences>(
          () async => await SharedPreferences.getInstance());
  }
}
