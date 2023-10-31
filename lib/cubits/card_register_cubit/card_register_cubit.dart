import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/core/api_bloc/api_req/ApiRequest.dart';
import 'package:xr_paynet/core/api_bloc/Endpoints.dart';
import 'package:xr_paynet/core/network/api_service.dart';
import 'package:xr_paynet/cubits/card_login_cubit/LoginResponse.dart';
import 'package:xr_paynet/cubits/card_register_cubit/RegisterResponse.dart';
import '../../constants/FormSubmissionStatus.dart';

part 'register_state.dart';

class CardRegisterCubit extends Cubit<RegisterState> {
  CardRegisterCubit() : super(const RegisterInit());

  clearState() {
    emit(const RegisterInit());
  }

  registerSubmitted({required String email, required String password}) async {
    emit(RegisterLoading(
        state.main.copyWith(status: FormSubmissionStatus.inProgress)));
    try {
      LoginRequest request = LoginRequest(email: email, password: password);
      ApiService("");

      dynamic response = await ApiService.hit(
          url: Uri.parse(USER_REGISTER), body: request, header: {});
      RegisterResponse res = RegisterResponse.fromJson(response);
      if (res.status == "200") {
        continueRegistration(res);
      } else {
        emitError(res.msg);
      }
    } catch (error) {
      emitError(error);
    }
  }

  emitError(error) {
    emit(RegisterError(
      state.main.copyWith(
          status: FormSubmissionStatus.failure,
          message: '',
          errorMessage: error.toString()),
    ));
  }

  continueRegistration(RegisterResponse user) {
    var dj = user.user_data?.message;
    print(dj);
    // if (user.user != null && user.error == null && user.authException == null) {
    emit(UserRegistered(state.main.copyWith(
        status: FormSubmissionStatus.success, message: dj, errorMessage: '')));
    // } else if (user.error == null && user.authException != null) {
    //   emit(RegisterEmailError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: user.authException!.message)));
    // } else {
    //   emit(RegisterEmailError(state.main.copyWith(status: FormSubmissionStatus.failure, message: '', errorMessage: user.error)));
    // }
  }
}
